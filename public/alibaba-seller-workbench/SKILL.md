---
name: alibaba-seller-workbench
description: Automate Alibaba Seller Workbench (阿里卖家工作台) desktop app for product management, order processing, inquiry handling, and data extraction. Use when user needs to batch operations on products, extract order data, manage inquiries, or perform repetitive tasks in the seller workbench. Windows-only with AutoHotkey v2.
---

# Alibaba Seller Workbench Automation (阿里卖家工作台)

## Prerequisites

- Windows 10/11
- AutoHotkey v2 installed (`winget install AutoHotkey.AutoHotkey`)
- Alibaba Seller Workbench desktop app installed and logged in

## Safety Rules

- **Read-only by default**: Extract data, copy text, capture screenshots
- **Confirm before write**: Any action that modifies data (update price, stock, status) requires explicit confirmation
- **Window focus check**: Always verify correct window is active before actions
- **Error handling**: If window not found or control unavailable, report error and stop

## Core Workflows

### 1. Product Management (产品管理)

#### Extract Product List
Extract visible products from the product list page:
- Product name
- SKU / Model
- Price
- Stock quantity
- Status (published/draft/offline)

**Usage**: Run `scripts/extract_product_list.ahk` while on product list page

#### Batch Update Fields (Confirmation Required)
Update multiple products:
- Price adjustments
- Stock updates
- Title optimization

**Safety**: Script generates preview first, user confirms, then applies

### 2. Order Processing (订单管理)

#### Extract Order Data
Extract order information:
- Order number
- Buyer info (name, country)
- Product details
- Amount
- Status
- Shipping info

**Script**: `scripts/extract_orders.ahk`

#### Order Status Summary
Generate daily/weekly order summary:
- New orders count
- Pending shipment
- Shipped orders
- Completed orders
- Dispute/after-sales

### 3. Inquiry Management (询盘管理)

#### Extract Inquiry List
Capture inquiry data:
- Buyer name/country
- Product interest
- Message preview
- Date
- Status (new/read/replied)

#### Quick Reply Templates
Pre-defined reply templates:
- Welcome message
- Product catalog request
- Quotation request
- Sample request
- MOQ explanation

**Usage**: Press hotkey to insert template, edit, then user sends manually

### 4. Data Center (数据中心)

#### Export Traffic Data
Extract visit/view data:
- Product views
- Store visits
- Inquiry count
- Response rate

## Hotkey Reference

| Hotkey | Function | Script |
|--------|----------|--------|
| `F8` | Extract current page products | `extract_product_list.ahk` |
| `F9` | Extract current orders | `extract_orders.ahk` |
| `Ctrl+F8` | Extract inquiry list | `extract_inquiries.ahk` |
| `Win+F8` | Capture current window data | `capture_window_data.ahk` |

## Troubleshooting

### Window Not Found
- Ensure Seller Workbench is open and visible
- Check if window title matches (may vary by version)
- Try clicking inside the window first

### Controls Not Accessible
- Some controls may require admin privileges
- Try running AutoHotkey script as Administrator
- Use coordinate-based fallback if control detection fails

### Data Incomplete
- Scroll to load more items before running script
- For long lists, script may need multiple runs
- Check if page is fully loaded (no loading indicators)

## Bundled Scripts

- `scripts/extract_product_list.ahk` - Extract product data from list view
- `scripts/extract_orders.ahk` - Extract order information
- `scripts/extract_inquiries.ahk` - Extract inquiry data
- `scripts/capture_window_data.ahk` - Generic window data capture
- `scripts/send_template_reply.ahk` - Insert reply template (no auto-send)

## Output Format

Scripts save data to:
```
Desktop\AlibabaSeller_YYYYMMDD_HHMMSS.txt
```

Format: Tab-separated or JSON for easy import to Excel/Database
