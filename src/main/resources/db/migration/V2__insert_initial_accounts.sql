-- 初期勘定科目データ（簿記3級レベルの基本科目）

-- 資産
INSERT INTO accounts (code, name, element) VALUES
('101', '現金', 'ASSET'),
('102', '当座預金', 'ASSET'),
('103', '普通預金', 'ASSET'),
('111', '売掛金', 'ASSET'),
('121', '前払金', 'ASSET'),
('131', '建物', 'ASSET'),
('132', '備品', 'ASSET'),
('141', '土地', 'ASSET');

-- 負債
INSERT INTO accounts (code, name, element) VALUES
('201', '買掛金', 'LIABILITY'),
('202', '借入金', 'LIABILITY'),
('211', '未払金', 'LIABILITY'),
('221', '前受金', 'LIABILITY');

-- 純資産
INSERT INTO accounts (code, name, element) VALUES
('301', '資本金', 'EQUITY'),
('311', '繰越利益剰余金', 'EQUITY');

-- 収益
INSERT INTO accounts (code, name, element) VALUES
('401', '売上', 'REVENUE'),
('411', '受取利息', 'REVENUE');

-- 費用
INSERT INTO accounts (code, name, element) VALUES
('501', '仕入', 'EXPENSE'),
('511', '給料', 'EXPENSE'),
('512', '水道光熱費', 'EXPENSE'),
('513', '旅費交通費', 'EXPENSE'),
('521', '支払利息', 'EXPENSE'),
('531', '減価償却費', 'EXPENSE');


