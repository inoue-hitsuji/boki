package com.boki.repository;

import com.boki.entity.JournalLine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface JournalLineRepository extends JpaRepository<JournalLine, Long> {
    
    List<JournalLine> findByAccountId(Long accountId);
    
    @Query("SELECT jl FROM JournalLine jl " +
           "JOIN jl.journalEntry je " +
           "WHERE jl.account.id = :accountId " +
           "AND je.entryDate >= :from AND je.entryDate <= :to " +
           "ORDER BY je.entryDate ASC, je.id ASC")
    List<JournalLine> findByAccountIdAndDateRange(
        @Param("accountId") Long accountId,
        @Param("from") LocalDate from,
        @Param("to") LocalDate to
    );
    
    @Query("SELECT COALESCE(SUM(jl.debitAmount), 0) - COALESCE(SUM(jl.creditAmount), 0) " +
           "FROM JournalLine jl " +
           "JOIN jl.journalEntry je " +
           "WHERE jl.account.id = :accountId " +
           "AND je.entryDate < :asOfDate")
    BigDecimal calculateBalanceBeforeDate(@Param("accountId") Long accountId, @Param("asOfDate") LocalDate asOfDate);
}


