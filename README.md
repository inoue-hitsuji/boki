# 複式簿記会計システム (Boki Accounting)

簿記3級レベルの知識を持つユーザー向けの複式簿記システムです。

## 技術スタック

- **バックエンド**: Java 17 + Spring Boot 3.2.0
- **データベース**: PostgreSQL
- **マイグレーション**: Flyway
- **フロントエンド**: React + TypeScript (予定)

## Day 1: セットアップ手順

### 1. PostgreSQLのセットアップ

```sql
-- PostgreSQLに接続してデータベースを作成
CREATE DATABASE boki_db;
```

または、`psql`コマンドで:
```bash
psql -U postgres -c "CREATE DATABASE boki_db;"
```

### 2. アプリケーション設定

`src/main/resources/application.yml`のデータベース接続情報を環境に合わせて変更:
```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/boki_db
    username: postgres
    password: postgres  # 実際のパスワードに変更
```

### 3. アプリケーション起動

```bash
mvn spring-boot:run
```

起動時にFlywayが自動的にマイグレーションを実行し、以下のテーブルが作成されます:
- `accounts` (勘定科目マスタ)
- `journal_entries` (仕訳ヘッダ)
- `journal_lines` (仕訳明細)

初期データとして、簿記3級レベルの基本勘定科目が自動投入されます。

## データベーススキーマ

### accounts (勘定科目)
- `id`: 主キー
- `code`: 勘定科目コード（一意）
- `name`: 勘定科目名
- `element`: 5要素（ASSET, LIABILITY, EQUITY, REVENUE, EXPENSE）
- `parent_id`: 親勘定科目（階層構造用、オプション）

### journal_entries (仕訳ヘッダ)
- `id`: 主キー
- `entry_date`: 取引日
- `description`: 摘要

### journal_lines (仕訳明細)
- `id`: 主キー
- `journal_entry_id`: 仕訳ヘッダへの外部キー
- `account_id`: 勘定科目への外部キー
- `debit_amount`: 借方金額
- `credit_amount`: 貸方金額
- 制約: 借方または貸方のいずれか一方のみが0より大きい値を持つ

## 次のステップ

- Day 2: 仕訳API（登録・一覧）の実装


