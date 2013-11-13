$(document).ready(function() {
  $("#myForm").on('submit',function(event){

    event.preventDefault();
    var url = $(this).attr("action")
                  // var tweet = $("limitedtextarea").val()};
                  var data =$(this).serialize();
                  console.log(data);
                  if ($("#tweet_area").val() ===  "")
                  {
                    alert("tweet field is empty");
                    return
                  }
                  else
                  {
                    $('.waiting').show();
                  }
                  console.log(url)
                  $.post(url, data,function(response){
                    $('.waiting').hide();
                    window.location.href=response
                    // console.log("#job)id")
                    


                  });          
                });

});

$("#myForm").on('submit',function(response)
    var jobId = data
    $.get('/status/' + JobId, function(response){
        var message = response
    $("#status").html(message);
    clearInterval(myIntervalId);

setInterval(recheck, 50000);
  });

});

