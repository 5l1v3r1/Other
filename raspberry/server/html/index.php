<?php

include('includes/header.php');
session_start();

$stream_url = 'http://' . $_SERVER['SERVER_ADDR'] . ':8080/?action=snapshot';

?>
      <body>
        <div class="container-fluid" style="margin: 40px 0;">
            <div class="row" style="padding-top: 80px;">
                <div class="col s6">
                    <div style="width: 680px; min-height: 510px !important; height: 478px;" id="stream">
                       <center>
                          <img src="<?php echo($stream_url) ?>" alt="Plants Growing" />
                       </center>
                    </div>
                    <h1>GreenBerry - Live Plants</h1>
                    <form method="POST" action="">
                        <p>
                            <p class="range-field">
                                <label>Raffraîchissement automatique:</label>
                                <input type="range" name="refresh" id="refresh" value="<?php echo($_SESSION['refresh']); ?>" min="1" max="50" onmouseup="document.forms[0].submit()" />
                            </p>
                        </p>
                    </form>
                </div>
            </div>
        </div>
      </body>
  </html>
<!-- End -->
