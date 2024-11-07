function validatePhone(txtPhone) {
    var a = document.getElementById(txtPhone).value;
    var filter = /^(\d{3}-\d{3}-\d{4}|\d{10})$/;
    if (filter.test(a)) {
        return true;
    }
    else {
        return false;
    }
}

function validateCard(cardNum) {
    var a = document.getElementById(cardNum).value;
    var filter = /^(\d{4}-\d{4}-\d{4}-\d{4}|\d{16})$/;
    if (filter.test(a)) {
        return true;
    }
    else {
        return false;
    }
}
function validateCVV(cardCVV) {
    var a = document.getElementById(cardCVV).value;
    var filter = /^(\d{3}|\d{4})$/;
    if (filter.test(a)) {
        return true;
    }
    else {
        return false;
    }
}


$(document).ready(function(){

     $('#loginForm').submit(function(event) {
        event.preventDefault();
        var username = $('#dropdownUsername').val().trim();
        var password = $('#dropdownPassword').val();

        // Simple client-side validation
        if(username === "" || password === "") {
            alert("Please fill out both username and password.");
        } else {
            
            alert("Form submitted");

            
        }
    });
});


    
    $("#phoneNumber").on("change", function(){
        if (!validatePhone("phoneNumber")){
            alert("Wrong format for phoneNumber");
            $("#phoneNumber").val("");
            $("#phoneNumber").addClass("error");
        }
        else {
            $("#phoneNumber").removeClass("error");
        }
    });



    
    $( "#bookingtDate" ).datepicker(
        {
            dateFormat: setDateFormat,
            minDate: new Date('02/01/2024'),  
            maxDate: '+4M',
            beforeShowDay: function(date) {
                var day = date.getDay();
                return [(day != 0), ''];
            }
        }   
    );
    $("#cardNumber").on("change", function(){
        if (!validateCard("cardNumber")){
            alert("Wrong format for cardNumber");
            $("#cardNumber").val("");
            $("#cardNumber").addClass("error");
        }
        else {
            $("#cardNumber").removeClass("error");
        }
    });
    $("#cardCVV").on("change", function(){
        if (!validateCard("cardCVV")){
            alert("Wrong format for cardCVV");
            $("#cardCVV").val("");
            $("#cardCVV").addClass("error");
        }
        else {
            $("#cardCVV").removeClass("error");
        }
    });



});

function validateBookingDateRange(startDateId, endDateId) {
    var startDate = new Date(document.getElementById(startDateId).value);
    var endDate = new Date(document.getElementById(endDateId).value);
    if (endDate >= startDate) {
        return true;
    } else {
        alert("End date must be after start date.");
        return false;
    }
}
$(document).ready(function() {
    $("#bookingForm").submit(function(event) {
        event.preventDefault(); 
        var isDateRangeValid = validateBookingDateRange('bookingDate', 'bookingEndDate');
        if (!isDateRangeValid) {
            return false;
        }
        alert('Form submitted successfully!');
        return true;
    });
});
