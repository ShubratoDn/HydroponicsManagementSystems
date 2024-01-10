package com.hydroponics.management.system.servicesImple;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.hydroponics.management.system.entities.Environment;
import com.hydroponics.management.system.entities.Notification;
import com.hydroponics.management.system.entities.User;
import com.hydroponics.management.system.payloads.PageableResponse;
import com.hydroponics.management.system.reopository.NotificationRepository;
import com.hydroponics.management.system.services.NotificationServices;

@Service
public class NotificationServiceImple implements NotificationServices  {
	
	@Autowired
	private NotificationRepository notificationRepository;
	
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

}

