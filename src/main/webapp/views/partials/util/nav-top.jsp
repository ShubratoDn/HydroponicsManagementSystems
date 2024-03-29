<%@page import="com.hydroponics.management.system.DTO.UserDTO" %>
    <% UserDTO loggedUser=(UserDTO) session.getAttribute("loggedUser"); %>

        <!-- Navbar-->
        <header class="main-header-top hidden-print">
            <a href="/home" class="logo"><img class="img-fluid able-logo"
                    src="${pageContext.request.contextPath}/assets//images/logo-white.png" alt="logo"></a>
            <nav class="navbar navbar-static-top">
                <!-- Sidebar toggle button-->
                <a href="#!" data-toggle="offcanvas" class="sidebar-toggle"></a>
                <ul class="top-nav lft-nav">
                    
                    <li class="dropdown"><a href="#!" data-toggle="dropdown" role="button" aria-haspopup="true"
                            aria-expanded="false" class="dropdown-toggle drop icon-circle drop-image"> <span>Dropdown
                            </span><i class=" icofont icofont-simple-down"></i>
                        </a>
                        <ul class="dropdown-menu settings-menu">
                            <li><a href="#">List item 1</a></li>
                            <li><a href="#">List item 2</a></li>
                            <li><a href="#">List item 3</a></li>
                            <li><a href="#">List item 4</a></li>
                            <li><a href="#">List item 5</a></li>
                        </ul>
                    </li>
                    <li class="dropdown pc-rheader-submenu message-notification search-toggle">
                        <a href="#!" id="morphsearch-search" class="drop icon-circle txt-white"> <i
                                class="ti-search"></i>
                        </a>
                    </li>
                </ul>
                <!-- Navbar Right Menu-->
                <div class="navbar-custom-menu f-right">
                    <ul class="top-nav">
                       <!--Notification Menu-->
                        <li class="dropdown notification-menu">
                            <a href="#!" data-toggle="dropdown" aria-expanded="false" class="dropdown-toggle">
                                <i class="icon-bell"></i>
                                <span class="badge badge-danger badge-top unread-notification-count" id="unread-notification-count">--</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="not-head">You have <b class="text-primary unread-notification-count" id="unread-notification-count">--</b> new notifications.</li>
                                
                                <ul id="nav-notification-container">
								 
								</ul>
								
								
                                <li class="not-footer">
                                    <a href="/my-notifications">See all notifications.</a>
                                </li>
                            </ul>
                        </li>


                        <!-- chat dropdown -->
                        <li class="pc-rheader-submenu ">
                            <a href="#!" class="drop icon-circle displayChatbox">
                                <i class="icon-bubbles"></i>
                                <span class="badge badge-danger header-badge">5</span>
                            </a>

                        </li>
                        <!-- window screen -->
                        <li class="pc-rheader-submenu">
                            <a href="#!" class="drop icon-circle" onclick="javascript:toggleFullScreen()">
                                <i class="icon-size-fullscreen"></i>
                            </a>

                        </li>




                        <!-- User Menu-->
                        <li class="dropdown">
                            <!-- USER INFORMATION -->
                            <a href="#!" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"
                                class="dropdown-toggle drop icon-circle drop-image">
                                <span><img class="img-circle nav-user-image"
                                        src="${pageContext.request.contextPath}/assets//images/userimages/<%=loggedUser != null ? loggedUser.getImage() : "" %>"
                                         alt="User Image"></span>
                                <span>
                                    <%=loggedUser !=null ? loggedUser.getFirstName() : "" %> <b class="text-muted">(
                                            <%=loggedUser !=null ? loggedUser.getRole() : "" %>)
                                        </b> <i class=" icofont icofont-simple-down"></i>
                                </span>

                            </a>
                            <ul class="dropdown-menu settings-menu">
                                <li><a href="#!"><i class="icon-settings"></i> Settings</a></li>
                                <li><a href="/user/<%=loggedUser == null ? "" : loggedUser.getId()%>"><i class="icon-user"></i> Profile</a></li>
                                <li><a href="#"><i class="icon-envelope-open"></i> My Messages</a></li>
                                <li class="p-0">
                                    <div class="dropdown-divider m-0"></div>
                                </li>
                                <li><a href="#"><i class="icon-lock"></i> Lock Screen</a></li>
                                <li><a href="/logout"><i class="icon-logout"></i> Logout</a></li>

                            </ul>
                        </li>
                    </ul>

                    <!-- search -->
                    <div id="morphsearch" class="morphsearch">
                        <form class="morphsearch-form">

                            <input class="morphsearch-input" type="search" placeholder="Search..." />

                            <button class="morphsearch-submit" type="submit">Search</button>

                        </form>
                        <div class="morphsearch-content">
                            <div class="dummy-column">
                                <h2>People</h2>
                                <a class="dummy-media-object" href="#!">
                                    <img class="round"
                                        src="http://0.gravatar.com/avatar/81b58502541f9445253f30497e53c280?s=50&d=identicon&r=G"
                                        alt="Sara Soueidan" />
                                    <h3>Sara Soueidan</h3>
                                </a>

                                <a class="dummy-media-object" href="#!">
                                    <img class="round"
                                        src="http://1.gravatar.com/avatar/9bc7250110c667cd35c0826059b81b75?s=50&d=identicon&r=G"
                                        alt="Shaun Dona" />
                                    <h3>Shaun Dona</h3>
                                </a>
                            </div>
                            <div class="dummy-column">
                                <h2>Popular</h2>
                                <a class="dummy-media-object" href="#!">
                                    <img src="${pageContext.request.contextPath}/assets//images/avatar-1.png"
                                        alt="PagePreloadingEffect" />
                                    <h3>Page Preloading Effect</h3>
                                </a>

                                <a class="dummy-media-object" href="#!">
                                    <img src="${pageContext.request.contextPath}/assets//images/avatar-1.png"
                                        alt="DraggableDualViewSlideshow" />
                                    <h3>Draggable Dual-View Slideshow</h3>
                                </a>
                            </div>
                            <div class="dummy-column">
                                <h2>Recent</h2>
                                <a class="dummy-media-object" href="#!">
                                    <img src="${pageContext.request.contextPath}/assets//images/avatar-1.png"
                                        alt="TooltipStylesInspiration" />
                                    <h3>Tooltip Styles Inspiration</h3>
                                </a>
                                <a class="dummy-media-object" href="#!">
                                    <img src="${pageContext.request.contextPath}/assets//images/avatar-1.png"
                                        alt="NotificationStyles" />
                                    <h3>Notification Styles Inspiration</h3>
                                </a>
                            </div>
                        </div>
                        <!-- /morphsearch-content -->
                        <span class="morphsearch-close"><i class="icofont icofont-search-alt-1"></i></span>
                    </div>
                    <!-- search end -->
                </div>
            </nav>
        </header>