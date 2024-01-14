// Function to update the notification menu
function updateNotificationMenu(data) {
    // Clear existing notifications
    $("#nav-notification-container").empty();

    // Initialize counts
    var totalMessages = 0;
    var unreadMessages = 0;

    // Loop through the notifications and append them to the menu
    data.content.forEach(function (notification) {
        // 1. Add notification-unread class if the status is UNREAD
        var notificationClass = notification.status === 'UNREAD' ? 'notification-unread' : '';

        // Increment totalMessages count
        totalMessages++;

        // Increment unreadMessages count if the status is UNREAD
        if (notification.status === 'UNREAD') {
            unreadMessages++;
        }

        // 2. Show only the first 20 characters of the message and add '...Read more'
        var shortMessage = notification.message.length > 20 ? notification.message.substring(0, 20) + '...Read more' : notification.message;

        // 3. Calculate the time difference and format it
        var timeAgo = calculateTimeAgo(notification.timestamp);

        var notificationHtml = `
		    <li class="bell-notification ${notificationClass}">
		        <a href="javascript:;" class="media" onclick="markAsReadAndRedirect(${notification.id}, '/notifications')">
		            <span class="media-left media-icon">
		                <img class="img-circle" src="${contextPath}/assets/images/avatar-2.png" alt="${notification.notificationType}">
		            </span>
		            <div class="media-body">
		                <span class="block">${notification.notificationType}</span>
		                <p class="text-justify">${shortMessage}</p>
		                <span class="text-muted block-time">${timeAgo}</span>
		            </div>
		        </a>
		    </li>`;


        $("#nav-notification-container").append(notificationHtml);
    });

	
	// Update the unread notification count
	$(".unread-notification-count").text(unreadMessages >= 10 ? "10+" : unreadMessages);
	
	// Check if there are more than 10 notifications and add a button
	if (totalMessages >= 10) {
	    // Add a button with an onclick event
	    $("#nav-notification-container").append('<a href="/notifications" class="text-info d-block text-center">You have more notifications</button>');
	}

}


function markAsReadAndRedirect(notificationId, redirectUrl) {
    // Perform the PUT request to mark the notification as read
    $.ajax({
        url: `/api/notification/${notificationId}/unread`,
        type: "PUT",
        success: function () {
            // Redirect to the specified URL after marking as read
            window.location.href = redirectUrl;
        },
        error: function (error) {
            console.error("Error marking notification as read:", error);
        }
    });
}


// Function to calculate the time ago
function calculateTimeAgo(timestamp) {
    var now = new Date();
    var notificationTime = new Date(timestamp);
    var timeDiff = now - notificationTime;

    // Calculate time ago in minutes, hours, or days
    if (timeDiff < 60000) {
        return Math.floor(timeDiff / 1000) + ' seconds ago';
    } else if (timeDiff < 3600000) {
        return Math.floor(timeDiff / 60000) + ' minutes ago';
    } else if (timeDiff < 86400000) {
        return Math.floor(timeDiff / 3600000) + ' hours ago';
    } else {
        return Math.floor(timeDiff / 86400000) + ' days ago';
    }
}

// Function to fetch notifications via AJAX
function fetchNotifications() {
    $.ajax({
        url: "/api/my-notifications/",
        type: "GET",
        dataType: "json",
        success: function (data) {
            // Call the updateNotificationMenu function with the received data
            updateNotificationMenu(data);
        },
        error: function (error) {
            console.error("Error fetching notifications:", error);
        }
    });
}

// Trigger the fetchNotifications function when the page loads
$(document).ready(function () {
    fetchNotifications();
    webSocketConnection();
});





//WORK FOR WEB SOCKET CONNECTION

/**
 * Step 1: Initialization
 */
stompClient = null;

//step 2
function webSocketConnection() {
	// Connect to WebSocket server
	var socket = SockJS("/HRM-WS");
	stompClient = Stomp.over(socket);
	stompClient.connect({}, function(frame) {
		console.log(frame);
		//userId is defined in every .jsp page
		stompClient.subscribe('/specific/notification/' + userId, function(result) {
			//if you got any new notification			
			addNewNotification(result);
		});
	});
}



// step 3
function sendNotification(event) {
	event.preventDefault();
	var userId = document.getElementById('userId').value;
	var message = document.getElementById('message').value;

	// You can now use userId and message to send the notification using WebSocket
	console.log("Sending notification to user " + userId + ": " + message);
	stompClient.send("/app/notification/"+userId+"/"+message, {});
}



function addNewNotification(result){
	var notification = JSON.parse(result.body);	
	
	// Initialize counts
    var unreadMessages = parseInt($("#unread-notification-count").text());
    
    // 1. Add notification-unread class if the status is UNREAD
    var notificationClass = notification.status === 'UNREAD' ? 'notification-unread' : '';

    // Increment unreadMessages count if the status is UNREAD
    if (notification.status === 'UNREAD') {
        unreadMessages++;
    }

    // 2. Show only the first 20 characters of the message and add '...Read more'
    var shortMessage = notification.message.length > 20 ? notification.message.substring(0, 20) + '...Read more' : notification.message;

    // 3. Calculate the time difference and format it
    var timeAgo = calculateTimeAgo(notification.timestamp);

    var notificationHtml = `
	    <li class="bell-notification ${notificationClass}">
	        <a href="javascript:;" class="media" onclick="markAsReadAndRedirect(${notification.id}, '/notifications')">
	            <span class="media-left media-icon">
	                <img class="img-circle" src="${contextPath}/assets/images/avatar-2.png" alt="${notification.notificationType}">
	            </span>
	            <div class="media-body">
	                <span class="block">${notification.notificationType}</span>
	                <p class="text-justify">${shortMessage}</p>
	                <span class="text-muted block-time">${timeAgo}</span>
	            </div>
	        </a>
	    </li>`;


    $("#nav-notification-container").append(notificationHtml);
    // Update the unread notification count
	$(".unread-notification-count").text(unreadMessages >= 10 ? "10+" : unreadMessages);
	
	
}
