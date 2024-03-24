package com.hydroponics.management.system.servicesImple;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.hydroponics.management.system.configs.Constants;
import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Invoice;
import com.hydroponics.management.system.entities.InvoiceItem;
import com.hydroponics.management.system.entities.Notification;
import com.hydroponics.management.system.entities.Payment;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.entities.enums.NotificationStatus;
import com.hydroponics.management.system.entities.enums.NotificationType;
import com.hydroponics.management.system.payloads.PageableResponse;
import com.hydroponics.management.system.reopository.NotificationRepository;
import com.hydroponics.management.system.services.NotificationServices;
import com.hydroponics.management.system.services.SmsServices;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class NotificationServiceImple implements NotificationServices  {
	
	@Autowired
	private NotificationRepository notificationRepository;
	
	@Autowired 
	private HelperServices helperServices;
		
	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;
	
	@Autowired
	private SmsServices smsServices;
	
	@Override
	public Notification sendNotification(Notification notification) {
		Notification save = notificationRepository.save(notification);
		return save;
	}
	

	@Override
	public Notification sendNotificationAndNotify(Notification notification) {
		Notification save = notificationRepository.save(notification);
		simpMessagingTemplate.convertAndSend("/specific/notification/" + save.getReceiver().getId(), save);
		return save;
	}


	@Override
	public Notification sendNotificationAfterVerify(Notification notification, double hour) {
		Timestamp now = new Timestamp(System.currentTimeMillis());
		Timestamp tenHoursAgo = new Timestamp(now.getTime() - ((long) hour * 60 * 60 * 1000));
		
		List<Notification> recentNotifications = notificationRepository.findByReceiverAndNotificationTypeAndEnvironmentAndTimestampAfter(notification.getReceiver(), notification.getNotificationType(), notification.getEnvironment(), tenHoursAgo);
		
		if(recentNotifications.size() > 0) {			
			return null;
		}
		
		Notification save = notificationRepository.save(notification);
		return save;
		
	}
	
	
	//get my notifications
	@Override
	public PageableResponse getMyNotifications(User user,int pageNumber, int pageSize, String sortBy, String sortDirection){
		Sort sort = null;
		if(sortBy != null && sortDirection != null && sortDirection.equalsIgnoreCase("asc")) {
			sort =  Sort.by(sortBy).ascending();
		}else {
			sort =  Sort.by(sortBy).descending();
		}
		
		Page<Notification> pageInfo;
		
		try {
			Pageable pageable = PageRequest.of(pageNumber, pageSize, sort);
			pageInfo = notificationRepository.findByReceiver(user, pageable);
		}catch (Exception e) {
			Pageable pageable = PageRequest.of(pageNumber, pageSize, Sort.by("id").descending());
			pageInfo = notificationRepository.findByReceiver(user, pageable);
		}
		
		
		List<Notification> content = pageInfo.getContent();
		
		List<Notification> notifications = new ArrayList<>();
		for(Notification notification : content) {
			if(notification.getEnvironment() != null) {
				notification.getEnvironment().setOwnedBy(null);
				notification.getEnvironment().setAddedEnvironmentBy(null);
				notification.getReceiver().setAddedBy(null);
				notification.getReceiver().setPassword(null);
				notification.getEnvironment().setMinerals(null);
			}
			
			notifications.add(notification);
		}
		
		PageableResponse pageData = new PageableResponse();
		pageData.setContent(notifications);
		pageData.setPageNumber(pageInfo.getNumber());
		pageData.setPageSize(pageInfo.getSize());
		pageData.setTotalElements(pageInfo.getTotalElements());
		pageData.setTotalPages(pageInfo.getTotalPages());
		pageData.setNumberOfElements(pageInfo.getNumberOfElements());

		pageData.setEmpty(pageInfo.isEmpty());
		pageData.setFirst(pageInfo.isFirst());
		pageData.setLast(pageInfo.isLast());
		
		
		return pageData;
	}

	@Override
	public Notification unreadNotification(Long id) {
		Notification notificationById = this.getNotificationById(id);
		if(notificationById == null) {
			return null;
		}
		notificationById.setStatus(NotificationStatus.READ);
		Notification save = notificationRepository.save(notificationById);
		return save;
	}
	

	@Override
	public Notification getNotificationById(Long id) {
		Notification notification = null;		
		try {
			notification = notificationRepository.findById(id).get();
		}catch (Exception e) {
			notification = null;
		}
		
		return notification;
	}

	
	
	@Override
	public void checkAndNotifyError(double actualValue, double baseValue, String fieldName,
            NotificationType notificationType, Environment environment) {
		
        if (!helperServices.isValidFieldData(actualValue, baseValue, Constants.MINERAL_ALLOWENCE_PERCENT)) {
            String errorMsg = "Hello Shubrato, Error in " + fieldName + ". Actual value is: " + actualValue +
                    ". It should be within the range of " + helperServices.givenPercentDecrease(baseValue, Constants.MINERAL_ALLOWENCE_PERCENT) +
                    " to " + helperServices.givenPercentIncrease(baseValue, Constants.MINERAL_ALLOWENCE_PERCENT) + ".";
            
            String smsMsg = "Hello "+environment.getOwnedBy().getFirstName()+", there's an issue with your "+environment.getPlantName()+" plants environment. "+fieldName.toUpperCase()+" is "+actualValue+", should be "+ helperServices.givenPercentDecrease(baseValue, Constants.MINERAL_ALLOWENCE_PERCENT) +" to " + helperServices.givenPercentIncrease(baseValue, Constants.MINERAL_ALLOWENCE_PERCENT) +". Please address this. Thank you.";
            log.error(errorMsg);

            Notification notification = new Notification();
            notification.setNotificationType(notificationType);
            notification.setEnvironment(environment);
            notification.setMessage(errorMsg);
            notification.setReceiver(environment.getOwnedBy());
            notification.setSender(null);
            notification.setStatus(NotificationStatus.UNREAD);
            
            Notification sendNotification = this.sendNotificationAfterVerify(notification, Constants.NOTIFICATION_TIME_INTERVAL_HOUR);
            
            if (sendNotification != null) {            	
            	//sending sms
            	smsServices.sendSms(environment.getOwnedBy().getPhone(), smsMsg);
                log.info("Notification: {} saved in the database.", notificationType);
                simpMessagingTemplate.convertAndSend("/specific/notification/" + sendNotification.getReceiver().getId(), sendNotification);
            } else {
                log.warn("Already saved Notification: {} in the database.", notificationType);
            }
        }
    }

	

	//check mineral and notify error
	@Override
	public void checkMineralAndNotifyError(double actualValue, double baseValue, String fieldName,
			NotificationType notificationType, Environment environment) {
		
		if (!helperServices.isValidFieldData(actualValue, baseValue, Constants.MINERAL_ALLOWENCE_PERCENT)) {
            String errorMsg = "Error in " + fieldName + ". Actual value is: " + actualValue +
                    ". It should be within the range of " + helperServices.givenPercentDecrease(baseValue, Constants.MINERAL_ALLOWENCE_PERCENT) +
                    " to " + helperServices.givenPercentIncrease(baseValue, Constants.MINERAL_ALLOWENCE_PERCENT) + ".";
            log.error(errorMsg);
            
            String smsMsg = "Hello "+environment.getOwnedBy().getFirstName()+", there's an issue with your "+environment.getPlantName()+" plants environment. "+fieldName.toUpperCase()+" is "+actualValue+", should be "+ helperServices.givenPercentDecrease(baseValue, Constants.MINERAL_ALLOWENCE_PERCENT) +" to " + helperServices.givenPercentIncrease(baseValue, Constants.MINERAL_ALLOWENCE_PERCENT) +". Please address this. Thank you.";

            Notification notification = new Notification();
            notification.setNotificationType(notificationType);
            notification.setEnvironment(environment);
            notification.setMessage(errorMsg);
            notification.setReceiver(environment.getOwnedBy());
            notification.setSender(null);
            notification.setStatus(NotificationStatus.UNREAD);
            notification.setMineral(fieldName);
            
            //sending notification
            Notification sendNotification = null;
            
            
            Timestamp now = new Timestamp(System.currentTimeMillis());
    		Timestamp tenHoursAgo = new Timestamp(now.getTime() - ((long) Constants.NOTIFICATION_TIME_INTERVAL_HOUR * 60 * 60 * 1000));
    		
    		List<Notification> recentNotifications = notificationRepository.findByReceiverAndNotificationTypeAndEnvironmentAndMineralAndTimestampAfter(notification.getReceiver(), notification.getNotificationType(), notification.getEnvironment(), notification.getMineral(), tenHoursAgo);
    		
    		if(recentNotifications.size() > 0) {
    			sendNotification = null;
    		}else {    			
    			sendNotification = notificationRepository.save(notification);            
    		}
    		
            
            if (sendNotification != null) {            	
            	smsServices.sendSms(sendNotification.getEnvironment().getOwnedBy().getPhone(), smsMsg);
            	
                log.info("Notification: {} saved in the database.", notificationType);
                simpMessagingTemplate.convertAndSend("/specific/notification/" + sendNotification.getReceiver().getId(), sendNotification);
            } else {
                log.warn("Already saved Notification: {} in the database.", notificationType);
            }
        }
		
		
	}
	
	

	@Override
	public Notification sendEnvWelcomeNotification(Environment addEnvironment) {
        
        Notification notification = new Notification();
        notification.setEnvironment(addEnvironment);
        notification.setReceiver(addEnvironment.getOwnedBy());
        notification.setSender(addEnvironment.getAddedEnvironmentBy());
        notification.setStatus(NotificationStatus.UNREAD);
        notification.setNotificationType(NotificationType.SUCCESS_ENVIRONMENT_CREATION);
        
        String msg = "🌱 Welcome to the Green Family, "+addEnvironment.getOwnedBy().getFirstName()+"!\n\n"
        	    + "We're excited to share the news of your brand-new hydroponics environment. Your oasis, located in "+addEnvironment.getLocation().getFullAddress()+", is now home to thriving "+addEnvironment.getPlantName()+". 🌿\n\n"
        	    + "A big shoutout to "+addEnvironment.getAddedEnvironmentBy().getFirstName()+" for making it happen! 🌟 Get ready for a journey of growth, freshness, and green goodness.\n\n"
        	    + "Stay tuned for updates on your flourishing plants!\n\n"
        	    + "Happy Growing! 🌱🌷🌿";
        
        notification.setMessage(msg);
        
        Notification sendNotificationAndNotify = this.sendNotificationAndNotify(notification);
        
		return sendNotificationAndNotify;
	}


	
	
	// send add payment notification
	@Override
	public Notification sendPaymentNotification(Payment payment) {

	    Notification notification = new Notification();
	    notification.setReceiver(payment.getInvoice().getUser());

	    switch (payment.getStatus()) {
	        case PAID:
	            notification.setNotificationType(NotificationType.SUCCESS_FULL_PAYMENT);
	            notification.setMessage("Thank you! Your payment of " +
	                                    payment.getAmount() + " taka for Invoice INV-000" +
	                                    payment.getInvoice().getId()+
	                                    " has been received successfully.");
	            break;
	        case PARTIAL_PAID:
	            notification.setNotificationType(NotificationType.SUCCESS_PARTIAL_PAYMENT);
	            notification.setMessage("Thank you! Your partial payment of " +
	                                    payment.getAmount() + " taka for Invoice INV-000" +
	                                    payment.getInvoice().getId() +
	                                    " has been received successfully. Remaining amount: " +
	                                    getRemainingAmount(payment.getAmount(),payment.getInvoice()) + " taka.");
	            break;
	        default:
	            notification.setNotificationType(NotificationType.UNPAID_PAYMENT);
	            notification.setMessage("Reminder: Your payment of " +
	                                    payment.getAmount() + " taka for Invoice INV-00" +
	                                    payment.getInvoice().getId() +
	                                    " is still pending. Please make the payment at your earliest convenience.");
	            break;
	    }
	    
	    notification.setStatus(NotificationStatus.UNREAD);
	    
	    Notification save = notificationRepository.save(notification);
	    smsServices.sendSms(save.getReceiver().getPhone(), "Hello "+save.getReceiver().getFirstName()+", "+save.getMessage()+" Best regards, LeafLab Team");
	    return save;
	}


	private double getRemainingAmount(Double paidAmount,Invoice invoice) {
		List<InvoiceItem> items = invoice.getItems();
	      double totalAmount = 0;
	        if (items != null) {
	            for (InvoiceItem item : items) {
	                if (item.getItemPrice() != null && item.getQuantity() != null) {
	                    totalAmount += item.getItemPrice().doubleValue() * item.getQuantity();
	                }
	            }
	        }
	    return (totalAmount-paidAmount);		
	}

	
	@Override
	public List<Notification> getUnreadNotifications(User user) {
		List<Notification> findByReceiverAndStatus = notificationRepository.findByReceiverAndStatus(user, NotificationStatus.UNREAD);
		return findByReceiverAndStatus;
	}
	
}

