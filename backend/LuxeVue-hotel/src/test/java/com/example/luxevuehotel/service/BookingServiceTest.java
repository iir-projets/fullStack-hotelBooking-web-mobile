package com.example.luxevuehotel.service;

import com.example.luxevuehotel.exception.InvalidBookingRequestException;
import com.example.luxevuehotel.exception.ResourceNotFoundException;
import com.example.luxevuehotel.model.BookedRoom;
import com.example.luxevuehotel.model.Room;
import com.example.luxevuehotel.repository.BookingRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@SpringBootTest
class BookingServiceTest {
    @Mock
    private BookingRepository bookingRepository;
    @Mock
    private IRoomService roomService;
    @InjectMocks
    private BookingService bookingService;
    private BookedRoom bookedRoom;
    @BeforeEach
    void setUp() {
        bookedRoom = new BookedRoom();
        bookedRoom.setCheckInDate(LocalDate.now());
        bookedRoom.setCheckOutDate(LocalDate.now().plusDays(3));
        bookedRoom.setBookingConfirmationCode("ABC123");

        Room room = new Room();
        room.setId(1L);
        room.setBookings(new ArrayList<>());

        when(roomService.getRoomById(1L)).thenReturn(Optional.of(room));
    }

    @Test
    void testSaveBookingWithUnavailableRoom() {
        Room room = new Room();
        room.setId(1L);
        room.setBookings(List.of(bookedRoom));
        when(roomService.getRoomById(1L)).thenReturn(Optional.of(room));

        assertThrows(InvalidBookingRequestException.class, () -> bookingService.saveBooking(1L, bookedRoom));
    }

    @Test
    void testCancelBooking() {
        bookingService.cancelBooking(1L);
        verify(bookingRepository, times(1)).deleteById(1L);
    }

    @Test
    void testGetAllBookings() {
        List<BookedRoom> bookedRooms = new ArrayList<>();
        bookedRooms.add(bookedRoom);
        when(bookingRepository.findAll()).thenReturn(bookedRooms);

        List<BookedRoom> result = bookingService.getAllBookings();
        assertEquals(1, result.size());
        assertEquals("ABC123", result.get(0).getBookingConfirmationCode());
    }

    @Test
    void testGetAllBookingsByRoomId() {
        List<BookedRoom> bookedRooms = new ArrayList<>();
        bookedRooms.add(bookedRoom);
        when(bookingRepository.findByRoomId(1L)).thenReturn(bookedRooms);

        List<BookedRoom> result = bookingService.getAllBookingsByRoomId(1L);
        assertEquals(1, result.size());
        assertEquals("ABC123", result.get(0).getBookingConfirmationCode());
    }

    @Test
    void testFindByBookingConfirmationCode() {
        when(bookingRepository.findByBookingConfirmationCode("ABC123")).thenReturn(Optional.of(bookedRoom));

        BookedRoom result = bookingService.findByBookingConfirmationCode("ABC123");
        assertNotNull(result);
        assertEquals("ABC123", result.getBookingConfirmationCode());
    }

    @Test
    void testFindByBookingConfirmationCodeNotFound() {
        when(bookingRepository.findByBookingConfirmationCode("XYZ456")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> bookingService.findByBookingConfirmationCode("XYZ456"));
    }


}
