<%@ page import="java.sql.*, com.demo.ConnectionDB" %>
<html lang="en">
   <head>
      <title>e-Hotels</title>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <!-- Style sheet (CSS) and JavaScript scripts necessary to use Bootstrap -->
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
      <script src="scripts/bookings.js"></script>
      <script src="https://kit.fontawesome.com/a03b673a1f.js" crossorigin="anonymous"></script>
      <!-- Your own additional style sheet -->
      <link href="styles/style.css" rel="stylesheet" type="text/css">
      <style>
         .bg-Hotels {
         position: relative;
         width: 100%;
         height: 100%;
         background-image: url('images/BG1.jpg');
         background-size: 100% 100%;
         background-repeat: no-repeat;
         }
         .bg-Hotels::before {
         content: "";
         position: absolute;
         top: 0;
         left: 0;
         width: 100%;
         height: 100%;
         background-color: rgba(44, 77, 168, 0.329);
         opacity: 0.1;
         }
         .bg-Hotels .container-md {
         position: relative;
         z-index: 5;
         padding: 100px;
         }
         .center-block {
         display: block;
         margin-left: auto;
         margin-right: auto;
         }
      </style>
      <style>
         .bg-pink {
         background-color: rgba(28, 68, 201, 0.322);
         }
         .dark-pink-button {
         background-color: rgb(11, 42, 143);
         border-color: rgb(63, 53, 83);
         }
         .dark-pink-button:hover {
         background-color: rgb(85, 48, 48);
         border-color: rgb(61, 42, 42);
         }
      </style>
   </head>
   <body>
      <!-- Navigation Bar with Login -->
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
         <a class="navbar-brand" href="#">e-Hotels</a>
         <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
         <span class="navbar-toggler-icon"></span>
         </button>
         <!-- Customer Login Form -->
         <form action="CustomerLoginServlet" method="post">
             <h2>Customer Login</h2>
             <label for="customerUsername">Username:</label>
             <input type="text" id="customerUsername" name="username" required>
             <label for="customerPassword">Password:</label>
             <input type="password" id="customerPassword" name="password" required>
             <button type="submit">Login</button>
         </form>

         <!-- Employee Login Form -->
         <form action="EmployeeLoginServlet" method="post">
             <h2>Employee Login</h2>
             <label for="employeeUsername">Username:</label>
             <input type="text" id="employeeUsername" name="username" required>
             <label for="employeePassword">Password:</label>
             <input type="password" id="employeePassword" name="password" required>
             <button type="submit">Login</button>
         </form>
      </nav>
      <div class="bg-Hotels">
         <div class="container-md p-3 my-3 border custom-container text-dark-pink">
            <img src="./main/webapp/assets/image/logo.png" class="center-block" alt="logo" style="height: 200px; width: 200px;">
            <div class="white-background">
               <br>
               <h4 class="text-center">Hotels For All</h4>
            </div>
         </div>
      </div>
      <div class="container">
         <nav class="row p-3 justify-content-center">
            <a href="#bookings" class="nav-link" id="navigateTobookings"><i class="fas fa-calendar-alt"></i> Bookings</a>
            <a href="#payment" class="nav-link" id="navigateToPayment"><i class="fas fa-dollar-sign"></i> Payments</a>
            <a href="#ContactUs" class="nav-link" id="navigateToContactUs"><i class="fas fa-envelope"></i> Contact us</a>
         </nav>
      </div>
      <style>
         .custom-table {
         background-color: rgb(55, 84, 148);
         }
      </style>
      <br>
      <div class="container border bg-pink" style="width: 1100px; justify-content: center;">
         <br>
         <button onclick="showBookingSection()">Book a Room</button>
         <div id="bookingSection" style="display:none;">
            <h2>Book Your Stay</h2>
            <form id="bookingForm">
               <label for="hotelSelect">Hotel:</label>
               <select id="hotelSelect" name="hotelId">
                  <!-- Options will be populated dynamically from the database -->
               </select>
               <!-- Start of the new star rating dropdown -->
               <label for="starRating">Star Rating:</label>
               <select id="starRating" name="starRating">
                  <option value="1">1 Star</option>
                  <option value="2">2 Stars</option>
                  <option value="3">3 Stars</option>
                  <option value="4">4 Stars</option>
                  <option value="5">5 Stars</option>
               </select>
               <!-- End of the new star rating dropdown -->
               <label for="roomTypeSelect">Room Type:</label>
               <select id="roomTypeSelect" name="roomType">
                  <option value="single">Single</option>
                  <option value="double">Double</option>
                  <option value="suite">Suite</option>
               </select>
               <label for="checkInDate">Check-in Date:</label>
               <input type="date" id="checkInDate" name="checkInDate" required>
               <label for="checkOutDate">Check-out Date:</label>
               <input type="date" id="checkOutDate" name="checkOutDate" required>
               <input type="submit" value="Book Now">
            </form>
         </div>
         <button onclick="showPaymentSection()">Proceed to Payment</button>
         <div id="paymentSection" style="display:none;">
            <h2>Payment</h2>
            <form id="paymentForm">
               <label for="cardNumber">Card Number:</label>
               <input type="text" id="cardNumber" name="cardNumber" required>
               <label for="expiryDate">Expiry Date:</label>
               <input type="text" id="expiryDate" name="expiryDate" required>
               <label for="cvv">CVV:</label>
               <input type="text" id="cvv" name="cvv" required>
               <input type="submit" value="Pay Now">
            </form>
         </div>
      </div>
      </div>
      <br>
      <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
      </div>
      </div>
      <!-- Including a modal https://www.w3schools.com/bootstrap4/bootstrap_modal.asp -->
      <!-- Here the modal is used for a little survey -->
      <div class="container">
         <h2><i class="fa-solid fa-clipboard-question"></i> Modal Example</h2>
         <!-- Trigger the modal with a button -->
         <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#mySurvey">Open Survey</button>
         <!-- Modal -->
         <div class="modal fade" id="mySurvey" role="dialog">
            <div class="modal-dialog">
               <div class="modal-content">
                  <div class="modal-header">
                     <h4 class="modal-title">Survey</h4>
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                  </div>
                  <div class="modal-body">
                     <div class="container">
                        <h2>How did you hear about us?</h2>
                        <p>Tell us:</p>
                        <form>
                           <div class="checkbox">
                              <label>
                              <input type="checkbox" value="Social Media"> Social Media
                              </label>
                           </div>
                           <div class="checkbox">
                              <label>
                              <input type="checkbox" value="Friends & Family"> Friends & Family
                              </label>
                           </div>
                           <div class="checkbox">
                              <label>
                              <input type="checkbox" value="Other" id="otherCheckbox"> Other
                              </label>
                              <input type="text" id="otherTextInput" style="display: none;">
                           </div>
                        </form>
                     </div>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- jQuery library -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
      <!-- Bootstrap JavaScript -->
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
      <!-- Custom JavaScript -->
      <script>
         document.addEventListener('DOMContentLoaded', function () {
             const otherCheckbox = document.getElementById('otherCheckbox');
             const otherTextInput = document.getElementById('otherTextInput');

             otherCheckbox.addEventListener('change', function () {
                 if (otherCheckbox.checked) {
                     otherTextInput.style.display = 'block';
                 } else {
                     otherTextInput.style.display = 'none';
                 }
             });
         });
      </script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
      <script>
         $(document).ready(function() {
             $('#Hotels, #bookingDate').change(function() {
                 var hotelId = $('#Hotels').val();
                 var date = $('#bookingDate').val();

                 $.get('checkAvailability', {hotelId: hotelId, date: date}, function(isAvailable) {
                     if (isAvailable === 'false') {
                         alert('The selected hotel is not available on the chosen date. Please select another date.');
                         $('#bookingDate').val(''); // reset the date input field
                     }
                 });
             });
         });
      </script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
      <script>
         $(document).ready(function() {
             // Handle login
             $('#loginForm').submit(function(event) {
                 event.preventDefault();
                 $.ajax({
                     type: 'POST',
                     url: 'LoginServlet',
                     data: $(this).serialize(),
                     success: function(response) {
                         // Assuming the response contains user info in JSON
                         var user = JSON.parse(response);
                         $('#loginSection').hide();
                         $('#dashboardSection').show();
                         $('#dashboardSection').html('Welcome, ' + user.name);
                     },
                     error: function() {
                         alert('Login failed!');
                     }
                 });
             });

             // Similar AJAX calls for booking and payment

         });
      </script>
      <script>
         $(document).ready(function() {
             // Populate hotels from the database on page load
             $.ajax({
                 type: 'GET',
                 url: 'HotelListServlet', // Servlet that returns the list of hotels as JSON
                 success: function(hotels) {
                     var options = "";
                     $.each(hotels, function(index, hotel) {
                         options += "<option value='" + hotel.id + "'>" + hotel.name + "</option>";
                     });
                     $('#hotelSelect').append(options);
                 }
             });

             // Handle booking form submission
             $('#bookingForm').submit(function(event) {
                 event.preventDefault();
                 $.ajax({
                     type: 'POST',
                     url: 'BookingServlet', // The URL of the servlet that handles booking
                     data: $(this).serialize(), // Serialize form data
                     success: function(response) {
                         // Handle the response from the server
                         alert('Booking successful!');
                     },
                     error: function() {
                         // Handle errors
                         alert('Booking failed. Please try again later.');
                     }
                 });
             });
         });
      </script>
      <script>
         function showBookingSection() {
           document.getElementById('bookingSection').style.display = 'block';
         }
      </script>
      <script>$(document).ready(function() {
         // Handle payment form submission
         $('#paymentForm').submit(function(event) {
             event.preventDefault();
             $.ajax({
                 type: 'POST',
                 url: 'PaymentServlet',
                 data: $(this).serialize(),
                 success: function(response) {
                     alert('Payment successful!');
                     // Redirect to a confirmation page or update the UI
                 },
                 error: function() {
                     alert('Payment failed. Please try again.');
                 }
             });
         });
         });
      </script>
      <script>
         function showPaymentSection() {
             document.getElementById('paymentSection').style.display = 'block';
         }
      </script>
      <script>
          $(document).ready(function() {
              $('#loginForm').submit(function(event) {
                  event.preventDefault();
                  $.ajax({
                      type: 'POST',
                      url: 'LoginServlet', // URL of the servlet that handles login
                      data: $(this).serialize(),
                      success: function(response) {
                          // Assuming the response contains a JSON object with a success flag and user name
                          var result = JSON.parse(response);
                          if (result.success) {
                              $('#loginSection').hide();
                              $('#dashboardSection').show();
                              $('#dashboardSection').html('Welcome, ' + result.userName);
                          } else {
                              alert('Login failed! Incorrect username or password.');
                          }
                      },
                      error: function() {
                          alert('Login failed! Please try again.');
                      }
                  });
              });
          });
      </script>
      <script>
      $(document).ready(function() {
          $('#bookingForm').change(function() {
              var hotelId = $('#hotelSelect').val();
              var roomType = $('#roomTypeSelect').val();
              var checkInDate = $('#checkInDate').val();
              var checkOutDate = $('#checkOutDate').val();

              // Make an AJAX call to check availability
              $.ajax({
                  type: 'GET',
                  url: 'CheckAvailabilityServlet',
                  data: {
                      hotelId: hotelId,
                      roomType: roomType,
                      checkInDate: checkInDate,
                      checkOutDate: checkOutDate
                  },
                  success: function(isAvailable) {
                      if (isAvailable === 'true') {
                          // Room is available
                          $('#bookingSubmitButton').prop('disabled', false);
                      } else {
                          // Room is not available
                          $('#bookingSubmitButton').prop('disabled', true);
                          alert('The selected room is not available for the chosen dates. Please select different dates or room type.');
                      }
                  }
              });
          });
      });
      </script>
      <div id="ContactUs"></div>
      <div class="container p-3 my-3 border bg-pink ">
         <h2> <i class="fas fa-envelope"></i> Contact Us</h2>
         <a href="#contact" class="btn btn-primary btn-block dark-pink-button" data-toggle="collapse">Contact Information</a>
         <div id="contact" class="collapse">
            <p><br>Phone Number: 123-456-7890</p>
            <p>Email Address: ehotels@email.com</p>
         </div>
         <a href="#address" class="btn btn-primary btn-block dark-pink-button" data-toggle="collapse">Location</a>
         <div id="address" class="collapse" style="height: fit-content;">
            <p><br>Location: 200 Main St. Ottawa, ON A1B 2C3</p>
            <div id="map-container-google-2" class="z-depth-1-half map-container" style="height: 180px">
               <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d719085.851534262!2d-76.4597105321139!3d45.24922630491754!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4cce05b25f5113af%3A0x8a6a51e131dd15ed!2sOttawa%2C%20ON!5e0!3m2!1sen!2sca!4v1707443294496!5m2!1sen!2sca" frameborder="0"
                  style="border:0" allowfullscreen></iframe>
            </div>
         </div>
      </div>
   </body>
</html>