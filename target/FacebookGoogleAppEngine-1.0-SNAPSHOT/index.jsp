<%--
  Created by IntelliJ IDEA.
  User: atiyakailany
  Date: 10/25/20
  Time: 2:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Facebook Login JavaScript</title>
    <meta charset="UTF-8">
</head>

<body>
<script>
    // This is called with the results from from FB.getLoginStatus().
    function statusChangeCallback(response) {
        console.log('statusChangeCallback');
        console.log(response);
        // The response object is returned with a status field that lets the
        // app know the current login status of the person.
        // Full docs on the response object can be found in the documentation
        // for FB.getLoginStatus().
        if (response.status === 'connected') {
            // Logged into your app and Facebook
            testAPI();
            userAge();
        }
        else {
            // The person is not logged into your app or we are unable to tell.
            document.getElementById('status').innerHTML = 'Please log ' +
                'into this app.';
        }
    }

    // This function is called when someone finishes with the Login
    // Button.  See the onlogin handler attached to it in the sample
    // code below.
    function checkLoginState() {
        FB.getLoginStatus(function(response) {
            statusChangeCallback(response);
        });
    }


    //CALL FB.init
    window.fbAsyncInit = function() {
        FB.init({
            appId      : '863638681041292',
            cookie     : true,  // enable cookies to allow the server to access
            // the session
            xfbml      : true,  // parse social plugins on this page
            version    : 'v8.0' // use graph api version 2.8
        });


        // NOW that we've initialized the JavaScript SDK, we call
        // FB.getLoginStatus().  This function gets the state of the
        // person visiting this page and can return one of three states to
        // the callback you provide.  They can be:
        //
        // 1. Logged into your app ('connected')
        // 2. Logged into Facebook, but not your app ('not_authorized')
        // 3. Not logged into Facebook and can't tell if they are logged into
        //    your app or not.
        //
        // These three cases are handled in the callback function.
        FB.getLoginStatus(function(response) {
            statusChangeCallback(response);
        });
    };



    // Load the SDK asynchronously
    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "https://connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));


    // Here we run a very simple test of the Graph API after login is
    // successful.  See statusChangeCallback() for when this call is made.
    function testAPI() {
        console.log('Welcome!  Fetching your information.... ');
        FB.api('/me', function(response) {
            console.log('Successful login for: ' + response.name);
            document.getElementById('status').innerHTML =
                'Thanks for logging in, ' + response.name + '!';
        });
    }

    function userAge() {
        FB.api('/me?fields=birthday', function(response) {
            var today = new Date();
            var birthDate = new Date(response.birthday);
            var age = today.getFullYear() - birthDate.getFullYear();
            var m = today.getMonth() - birthDate.getMonth();
            if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
                age--;
            }
            document.getElementById('birthday').innerHTML =
                'User birthday is, ' + response.birthday;

            document.getElementById('age').innerHTML =
                'User age is, ' + age;
        });
    }

    // function userAge() {
    //     FB.api(
    //         '/me?fields=birthday',
    //         'GET',
    //         {"fields":"id,name,birthday"},
    //         function(response) {
    //             // Insert your code here
    //             document.getElementById('status').innerHTML =
    //                 'User age is: ' + response.birthday;
    //         }
    //     );
    // }

    // Here we run a very simple test of the Graph API after login is
    // successful to post a message to the user me. See statusChangeCallback() for when this call is made.
    function testMessageCreate() {
        console.log('Posting a message to user feed.... ');
        //first must ask for permission to post and then will have call back function defined right inline code
        // to post the message.
        FB.login(function(){
            var typed_text = document.getElementById("message_text").value;

            FB.ui({
                method: 'share',
                href: 'https://www.csueastbay.edu/',
                quote: typed_text,
            }, function(response){
                document.getElementById('theText').innerHTML = 'Thanks for posting the message: ' + typed_text;
            });

        }//end log in

        );}//end func

</script>

<!--    Below we include the Login Button social plugin. This button uses
    the JavaScript SDK to present a graphical Login button that triggers
    the FB.login() function when clicked.  -->

<fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
</fb:login-button>

<div id="status">  </div>

<div id="birthday">  </div>
<div id="age">  </div>

Hit Button to Post Message to Feed
<input type="text" value="enter in text" id="message_text"/>
<input type="button" value="enter" onclick="testMessageCreate();"/>
<br><br>

<div id="theText"></div>

</body>
</html>
