<?php

include('includes/header.php');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    session_destroy();
    session_start();
}

$stream_url = 'http://' . $_SERVER['SERVER_ADDR'] . ':8080/';

?>
      <body>
        <div class="container-fluid" style="margin: 40px 0;">
            <div class="row" style="padding-top: 80px;">
                <div class="col s6">
                    <div style="width: 100%; min-height: 720px !important; height: auto;" id="stream">
                        <iframe src="<?php echo($stream_url) ?>"></iframe>
                    </div>
                </div>
                <div class="col s6">
                    <h1>GreenBerry - Live Plants</h1>
                    <form method="POST" action="">
                        <p>
                            <p class="range-field">
                                <label>Raffraîchissement automatique:</label>
                                <input type="range" name="refresh" id="refresh" min="1" max="50" onmouseup="document.forms[0].submit()" />
                                
                            </p>
                        </p>
                    </form>
                </div>
            </div>
        </div>
      </body>
  </html>
<!-- End -->
