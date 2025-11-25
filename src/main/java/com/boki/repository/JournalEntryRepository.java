package com.boki.repository;

import com.boki.entity.JournalEntry;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface JournalEntryRepository extends JpaRepository<JournalEntry, Long> {
    
    List<JournalEntry> findByEntryDateBetweenOrderByEntryDateAsc(LocalDate from, LocalDate to);
    
    @Query("SELECT je FROM JournalEntry je WHERE je.entryDate >= :from AND je.entryDate <= :to ORDER BY je.entryDate ASC, je.id ASC")
    List<JournalEntry> findEntriesInPeriod(@Param("from") LocalDate from, @Param("to") LocalDate to);
}


