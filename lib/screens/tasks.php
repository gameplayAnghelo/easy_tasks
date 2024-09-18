<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
$conn = new mysqli('localhost', 'root', '', 'flutter_db');

if ($conn->connect_error) {
    die('Connection failed: ' . $conn->connect_error);
}

$action = $_GET['action'] ?? '';

if ($action === 'addTask') {
    $data = json_decode(file_get_contents('php://input'), true);
    
    file_put_contents('debug.txt', print_r($data, true));

    $stmt = $conn->prepare('INSERT INTO tasks (name, description, priority, startDate, endDate, icon, startTime, endTime, notificationType, notificationTime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)');
    
    if ($stmt === false) {
        file_put_contents('debug.txt', 'Prepare failed: ' . $conn->error, FILE_APPEND);
        exit;
    }

    $stmt->bind_param(
        'ssssssssss',
        $data['name'] ?? null,
        $data['description'] ?? null,
        $data['priority'] ?? null,
        $data['startDate'] ?? null,
        $data['endDate'] ?? null,
        $data['icon'] ?? null,
        $data['startTime'] ?? null,
        $data['endTime'] ?? null,
        $data['notificationType'] ?? null,
        $data['notificationTime'] ?? null
    );
    
    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'error' => $stmt->error]);
    }
}

$conn->close();
?>
