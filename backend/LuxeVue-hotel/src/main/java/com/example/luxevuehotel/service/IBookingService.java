package com.example.luxevuehotel.service;

import com.example.luxevuehotel.model.BookedRoom;

import java.util.List;

public interface IBookingService {
    List<BookedRoom> getAllBookingsByRoomId(Long roomId);

    void cancelBooking(Long bookingId);

    String saveBooking(Long roomId, BookedRoom bookingRequest);

    BookedRoom findByBookingConfirmationCode(String confirmationCode);

    List<BookedRoom> getAllBookings();
}
