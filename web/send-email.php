<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Collect form data
    $name = $_POST['name'];
    $email = $_POST['email'];
    $subject = $_POST['subject'];
    $message = $_POST['message'];

    $to = "kilakori@proton.me";

    $headers = "From: punschabend@schmoewe.de\r\n";
    $headers .= "Reply-To: $email\r\n";
    $headers .= "Content-Type: text/html; charset=UTF-8\r\n";

    // Build the email content
    $email_content = "<h2>Neue Nachricht</h2>";
    $email_content .= "<p><strong>Name:</strong> $name</p>";
    $email_content .= "<p><strong>Email:</strong> $email</p>";
    $email_content .= "<p><strong>Betreff:</strong> $subject</p>";
    $email_content .= "<p><strong>Nachricht:</strong><br>$message</p>";

    // Send the email
    if (mail($to, $subject, $email_content, $headers)) {
        echo "Deine Nachricht wurde gesendet. Danke!";
    } else {
        echo "Fehler beim Senden der Nachricht.";
    }
}
?>
