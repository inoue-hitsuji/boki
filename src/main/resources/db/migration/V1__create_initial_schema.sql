-- 勘定科目マスタ（5要素: 資産、負債、純資産、費用、収益）
CREATE TABLE accounts (
    id BIGSERIAL PRIMARY KEY,
    code VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    element VARCHAR(20) NOT NULL CHECK (element IN ('ASSET', 'LIABILITY', 'EQUITY', 'REVENUE', 'EXPENSE')),
    parent_id BIGINT REFERENCES accounts(id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_accounts_code ON accounts(code);
CREATE INDEX idx_accounts_element ON accounts(element);

-- 仕訳ヘッダ
CREATE TABLE journal_entries (
    id BIGSERIAL PRIMARY KEY,
    entry_date DATE NOT NULL,
    description VARCHAR(500),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_journal_entries_date ON journal_entries(entry_date);

-- 仕訳明細（借方・貸方）
CREATE TABLE journal_lines (
    id BIGSERIAL PRIMARY KEY,
    journal_entry_id BIGINT NOT NULL REFERENCES journal_entries(id) ON DELETE CASCADE,
    account_id BIGINT NOT NULL REFERENCES accounts(id),
    debit_amount DECIMAL(15, 2) DEFAULT 0 CHECK (debit_amount >= 0),
    credit_amount DECIMAL(15, 2) DEFAULT 0 CHECK (credit_amount >= 0),
    CHECK (debit_amount > 0 OR credit_amount > 0),
    CHECK (NOT (debit_amount > 0 AND credit_amount > 0)),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_journal_lines_entry ON journal_lines(journal_entry_id);
CREATE INDEX idx_journal_lines_account ON journal_lines(account_id);
CREATE INDEX idx_journal_lines_date_account ON journal_lines(journal_entry_id, account_id);

-- 更新日時を自動更新する関数
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 更新日時トリガー
CREATE TRIGGER update_accounts_updated_at BEFORE UPDATE ON accounts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_journal_entries_updated_at BEFORE UPDATE ON journal_entries
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();


