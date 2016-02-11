$.validator.addMethod("check_date_of_birth", function(value, element) {

    var day = $("#user_date_of_birth_3i").val();
    var month = $("#user_date_of_birth_2i").val();
    var year = $("#user_date_of_birth_1i").val();
    var age =  18;

    var mydate = new Date();
    mydate.setFullYear(year, month-1, day);

    var currdate = new Date();
    currdate.setFullYear(currdate.getFullYear() - age);

    return currdate > mydate;

}, "You must be at least 18 years of age.");