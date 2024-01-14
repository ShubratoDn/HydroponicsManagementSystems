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
import com.hydroponics.management.system.entities.Notification;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.entities.enums.NotificationStatus;
import com.hydroponics.management.system.entities.enums.NotificationType;
import com.hydroponics.management.system.payloads.PageableResponse;
import com.hydroponics.management.system.reopository.NotificationRepository;
import com.hydroponics.management.system.services.HelperServices;
import com.hydroponics.management.system.services.NotificationServices;

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
	
	@Override
	public Notification sendNotification(Notification notification) {
		Notification save = notificationRepository.save(notification);
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
			notification.getEnvironment().setOwnedBy(null);
			notification.getEnvironment().setAddedEnvironmentBy(null);
			notification.getReceiver().setAddedBy(null);
			notification.getReceiver().setPassword(null);
			notification.getEnvironment().setMinerals(null);
			
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
	public void checkAndNotifyError(double actualValue, double expectedValue, String fieldName,
            NotificationType notificationType, Environment environment) {
		
        if (!helperServices.isValidFieldData(actualValue, expectedValue, Constants.MINERAL_ALLOWENCE_PERCENT)) {
            String errorMsg = "Error in " + fieldName + ". Actual value is: " + actualValue +
                    ". It should be within the range of " + helperServices.givenPercentDecrease(actualValue, Constants.MINERAL_ALLOWENCE_PERCENT) +
                    " to " + helperServices.givenPercentIncrease(actualValue, Constants.MINERAL_ALLOWENCE_PERCENT) + ".";
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
                log.info("Notification: {} saved in the database.", notificationType);
                simpMessagingTemplate.convertAndSend("/specific/notification/" + sendNotification.getReceiver().getId(), sendNotification);
            } else {
                log.warn("Already saved Notification: {} in the database.", notificationType);
            }
        }
    }
	

}

