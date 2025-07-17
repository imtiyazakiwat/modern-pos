# How to Display Customer GST Number Under Customer Name in Invoices

After running the database migration files (`alter2.sql` and `migrate_gst_numbers.php`), follow these steps to display the GST number under the customer name in your invoice templates:

## Step 1: Access the Receipt Template Editor

1. Log in to your admin panel
2. Navigate to "POS Settings" > "Receipt Template"

## Step 2: Edit Your Templates

Find the section in your template where the customer name is displayed. This typically looks something like:

```html
<div class="customer-name">{{ customer_name }}</div>
```

Modify it to include the GST number under the customer name:

```html
<div class="customer-name">{{ customer_name }}</div>
{% if customer_gst_number %}
<div class="customer-gst">GST No: {{ customer_gst_number }}</div>
{% endif %}
```

## Example Template Modification

Before:
```html
<div class="customer-details">
  <div class="customer-name">{{ customer_name }}</div>
  <div class="customer-address">{{ customer_address }}</div>
  <div class="customer-phone">{{ customer_phone }}</div>
</div>
```

After:
```html
<div class="customer-details">
  <div class="customer-name">{{ customer_name }}</div>
  {% if customer_gst_number %}
  <div class="customer-gst">GST No: {{ customer_gst_number }}</div>
  {% endif %}
  <div class="customer-address">{{ customer_address }}</div>
  <div class="customer-phone">{{ customer_phone }}</div>
</div>
```

## Step 3: Save Your Template Changes

Click the "Save" button to update your receipt template.

## Step 4: Preview the Template

Use the "Preview" button to see how your modified template looks with the GST number.

## Notes

- The GST number will only appear if it's available for the customer
- The template uses conditional display (`{% if customer_gst_number %}`) so it won't show anything if no GST number is present
- You can style the GST number display by adding CSS to match your template design 