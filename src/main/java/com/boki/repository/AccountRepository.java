package com.boki.repository;

import com.boki.entity.Account;
import com.boki.entity.Account.AccountElement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AccountRepository extends JpaRepository<Account, Long> {
    
    Optional<Account> findByCode(String code);
    
    List<Account> findByElement(AccountElement element);
    
    List<Account> findAllByOrderByCodeAsc();
}


