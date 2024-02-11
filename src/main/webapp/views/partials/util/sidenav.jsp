		<!-- Side-Nav-->
        <aside class="main-sidebar hidden-print ">
            <section class="sidebar" id="sidebar-scroll">
            
            	<%            	
            		String role = "user";
            	
	            	if(loggedUser != null){
	            		role = loggedUser.getRole().toLowerCase();
	            	}
            	
            		if(role.equals("admin") || role.equals("owner") || role.equals("staff")){            			
            		
            	%>
            
                <!-- Sidebar Menu-->
                <ul class="sidebar-menu">
                	<li class="nav-level">--- Navigation </li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/">
                            <i class="icon-home"></i><span>Home</span>
                        </a>
                    </li>
                    <li class="nav-level">--- Manage User</li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/add-user">
                            <i class="icon-plus"></i><span> Add User</span>
                        </a>
                    </li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/user/all">
                            <i class="icon-user"></i><span> All user</span>
                        </a>
                    </li>
                    <li class="nav-level">--- Location Management</li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/add-location">
                            <i class="icon-map"></i><span>Add Location</span>
                        </a>
                    </li>
                    <li class="nav-level">---Manage Environment</li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/my-environments">
                            <i class="icon-map"></i><span> My Environments</span>
                        </a>
                        
                    </li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/add-environment">
                            <i class="icon-plus"></i><span>Add Environment</span>
                        </a>
                    </li>                    
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/find-environments">
                            <i class="icon-magnifier"></i><span>Find Environments</span>
                        </a>
                    </li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/all-environments">
                            <i class="icon-map"></i><span>All Environments</span>
                        </a>
                    </li>
                    
                     <li class="nav-level">--- Generate Fake Data</li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/generate-data/">
                            <i class="icon-people"></i><span>Fake data Form</span>
                        </a>
                    </li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/generate-data/random/environment">
                            <i class="icon-people"></i><span>Generate Random Data</span>
                        </a>
                    </li>
                    
					<li class="nav-level">--- Notification</li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/my-notifications">
                            <i class="icon-bell"></i><span>Notifications</span>
                        </a>
                    </li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/send-notification">
                            <i class="icon-paper-plane"></i><span>Send notification</span>
                        </a>
                    </li>
                    
                                       
                    <li class="nav-level">--- Menu Level</li>

                    <li class="treeview"><a class="waves-effect waves-dark" href="#!"><i
                                class="icofont icofont-company"></i><span>Menu Level 1</span><i
                                class="icon-arrow-down"></i></a>
                        <ul class="treeview-menu">
                            <li>
                                <a class="waves-effect waves-dark" href="#!">
                                    <i class="icon-arrow-right"></i>
                                    Level Two
                                </a>
                            </li>
                            <li class="treeview">
                                <a class="waves-effect waves-dark" href="#!">
                                    <i class="icon-arrow-right"></i>
                                    <span>Level Two</span>
                                    <i class="icon-arrow-down"></i>
                                </a>
                                <ul class="treeview-menu">
                                    <li>
                                        <a class="waves-effect waves-dark" href="#!">
                                            <i class="icon-arrow-right"></i>
                                            Level Three
                                        </a>
                                    </li>
                                    <li>
                                        <a class="waves-effect waves-dark" href="#!">
                                            <i class="icon-arrow-right"></i>
                                            <span>Level Three</span>
                                            <i class="icon-arrow-down"></i>
                                        </a>
                                        <ul class="treeview-menu">
                                            <li>
                                                <a class="waves-effect waves-dark" href="#!">
                                                    <i class="icon-arrow-right"></i>
                                                    Level Four
                                                </a>
                                            </li>
                                            <li>
                                                <a class="waves-effect waves-dark" href="#!">
                                                    <i class="icon-arrow-right"></i>
                                                    Level Four
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                </ul>                
                <%
            		}
                %>
                
                
                
                
                
                
                <!-- =================================================== -->
				<!-- NORMAL USER's SIDENAVE -->
				<!-- =================================================== -->
                <%            	
            	            		
            		if(role.equals("user")){            			
            		
            	%>
            
                <!-- Sidebar Menu-->
                <ul class="sidebar-menu">
                	<li class="nav-level">--- Navigation </li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/">
                            <i class="icon-home"></i><span>Home</span>
                        </a>
                    </li>
                    <li class="nav-level">--- Environments</li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/my-environments">
                            <i class="icon-map"></i><span> My Environments</span>
                        </a>
                    </li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/find-environments">
                            <i class="icon-magnifier"></i><span>Find Environments</span>
                        </a>
                    </li>
                    
                    
                    <li class="nav-level">--- Notification</li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/my-notifications">
                            <i class="icon-bell"></i><span>Notifications</span>
                        </a>
                    </li>
                    
                    
                    
                    
                    <li class="nav-level">--- Support</li>
                    <li class="treeview">
                        <a class="waves-effect waves-dark" href="/contact-us">
                            <i class="icofont-envelope"></i><span>Contact Us</span>
                        </a>
                    </li>
                    
                    
                                       
                    <li class="nav-level">--- Menu Level</li>

                    <li class="treeview"><a class="waves-effect waves-dark" href="#!"><i
                                class="icofont icofont-company"></i><span>Menu Level 1</span><i
                                class="icon-arrow-down"></i></a>
                        <ul class="treeview-menu">
                            <li>
                                <a class="waves-effect waves-dark" href="#!">
                                    <i class="icon-arrow-right"></i>
                                    Level Two
                                </a>
                            </li>
                            <li class="treeview">
                                <a class="waves-effect waves-dark" href="#!">
                                    <i class="icon-arrow-right"></i>
                                    <span>Level Two</span>
                                    <i class="icon-arrow-down"></i>
                                </a>
                                <ul class="treeview-menu">
                                    <li>
                                        <a class="waves-effect waves-dark" href="#!">
                                            <i class="icon-arrow-right"></i>
                                            Level Three
                                        </a>
                                    </li>
                                    <li>
                                        <a class="waves-effect waves-dark" href="#!">
                                            <i class="icon-arrow-right"></i>
                                            <span>Level Three</span>
                                            <i class="icon-arrow-down"></i>
                                        </a>
                                        <ul class="treeview-menu">
                                            <li>
                                                <a class="waves-effect waves-dark" href="#!">
                                                    <i class="icon-arrow-right"></i>
                                                    Level Four
                                                </a>
                                            </li>
                                            <li>
                                                <a class="waves-effect waves-dark" href="#!">
                                                    <i class="icon-arrow-right"></i>
                                                    Level Four
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                </ul>                
                <%
            		}
                %>
                
                
                
                
                
                
                
                
            </section>
        </aside>
        
        
        
        
        
        
        
        
        
        
        
        
        <!-- Include jQuery library -->
<script src="${pageContext.request.contextPath}/assets//js/jquery.min.js"></script>

<script>
$(document).ready(function() {
    // Get the current URL path
    var path = window.location.pathname;

    // Find the <a> element with matching href and add the 'active' class to its parent <li>
    $('.treeview a').each(function() {
        var href = $(this).attr('href');
        
        if(path === "/home"  && href ==="/"){
        	$(this).closest('li').addClass('active');
        }else if(path === "/generate-data"  && href ==="/generate-data/"){
        	$(this).closest('li').addClass('active');
        }else if (path === href) {
            $(this).closest('li').addClass('active');
        }
    });
})
</script>
