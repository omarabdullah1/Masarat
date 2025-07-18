# API Integration Guide

This document provides a guide for integrating with the Masarat API.

## Base URLs

| Environment | URL |
|-------------|-----|
| Development | `https://dev-api.masarat.example.com/v1` |
| Staging     | `https://staging-api.masarat.example.com/v1` |
| Production  | `https://api.masarat.example.com/v1` |

## Authentication

### Login

**Endpoint**: `POST /auth/login`

**Request Body**:
```json
{
  "email": "user@example.com",
  "password": "password123",
  "role": "student"  // Can be "student" or "instructor"
}
```

**Response**:
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "123",
    "name": "John Doe",
    "email": "user@example.com",
    "role": "student"
  }
}
```

### Registration

**Endpoint**: `POST /auth/register`

**Request Body**:
```json
{
  "name": "John Doe",
  "email": "user@example.com",
  "password": "password123",
  "role": "student"  // Can be "student" or "instructor"
}
```

**Response**:
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "123",
    "name": "John Doe",
    "email": "user@example.com",
    "role": "student"
  }
}
```

## Courses

### Get All Courses

**Endpoint**: `GET /courses`

**Query Parameters**:
- `page`: Page number (default: 1)
- `limit`: Number of items per page (default: 10)
- `search`: Search term for course title
- `category`: Filter by category ID
- `level`: Filter by level (beginner, intermediate, advanced)

**Response**:
```json
{
  "total": 100,
  "page": 1,
  "limit": 10,
  "courses": [
    {
      "id": "course123",
      "title": "Introduction to Flutter",
      "description": "Learn Flutter basics",
      "coverImageUrl": "https://example.com/images/flutter.jpg",
      "instructorId": "instructor123",
      "instructorName": "Jane Smith",
      "level": "beginner",
      "durationEstimate": "10 hours",
      "price": 49.99,
      "rating": 4.8,
      "reviewCount": 120
    },
    // More courses...
  ]
}
```

### Get Course Details

**Endpoint**: `GET /courses/{courseId}`

**Response**:
```json
{
  "id": "course123",
  "title": "Introduction to Flutter",
  "description": "Learn Flutter basics",
  "coverImageUrl": "https://example.com/images/flutter.jpg",
  "instructorId": "instructor123",
  "instructorName": "Jane Smith",
  "level": "beginner",
  "durationEstimate": "10 hours",
  "price": 49.99,
  "rating": 4.8,
  "reviewCount": 120,
  "lectures": [
    {
      "id": "lecture1",
      "title": "Getting Started",
      "duration": "00:45:30",
      "videoUrl": "https://example.com/videos/lecture1.mp4"
    },
    // More lectures...
  ]
}
```

## Error Handling

All API endpoints return standard HTTP status codes:

- `200 OK`: Request successful
- `201 Created`: Resource created successfully
- `400 Bad Request`: Invalid request parameters
- `401 Unauthorized`: Authentication failure
- `403 Forbidden`: Permission denied
- `404 Not Found`: Resource not found
- `500 Internal Server Error`: Server error

Error responses have the following format:

```json
{
  "error": {
    "code": "INVALID_CREDENTIALS",
    "message": "The provided credentials are invalid"
  }
}
```

## Rate Limiting

API requests are rate-limited to 100 requests per minute per user. When rate limited, the API will return a `429 Too Many Requests` status code.
