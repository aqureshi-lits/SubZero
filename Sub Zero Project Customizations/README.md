# Subzero Pallet Rental – AL Extension (v2, physical-pallet model)

This package **replaces the CBM-derived pallet engine** of your original package with an
**actual physical-pallet occupancy** model, and adds the three Subzero billing scenarios,
Pallet-ID (barcode) generation on purchase receipt, and order-level scenario copy.

## What changed vs. the original package

| Area | Original (v1) | This package (v2) |
|------|---------------|-------------------|
| Pallet count | Derived: `Customer CBM ÷ Item Cubage` | Counted from real `Pallet Register` records |
| Pallet identity | none | **Pallet ID barcode** per lot, generated on purchase receipt |
| Billing methods | single (occupancy × rate) | **Normal / Fixed Location / Fixed Days** |
| Scenario on order | none | Copied Customer → Sales Order (editable per order) |
| Storage-condition rate | Item `Rent Pallet/Day` | Reused as-is (Ambient/Frozen/Chilled) |

You can keep the original v1 objects installed; this package uses **new object IDs (80020+)**
and new tableextension IDs, so there are no collisions.

## Objects in this package (ID range 80020–80050)

| Type | ID | Name |
|------|----|------|
| Enum | 80020 | Pallet Rental Billing Method |
| Enum | 80021 | Pallet Status |
| Table | 80020 | Pallet Rental Setup |
| Table | 80021 | Pallet Register |
| Table | 80022 | Pallet Rental Billing Line |
| TableExt | 80023 | Customer (scenario fields) |
| TableExt | 80024 | Item (Qty. per Pallet) |
| TableExt | 80025 | Sales Header (scenario fields) |
| Codeunit | 80020 | Pallet Rental Mgt. (ID gen + shipment + copy) |
| Report | 80050 | Calc. Pallet Rental (billing engine) |
| Page | 80020 | Pallet Rental Setup |
| Page | 80021 | Pallet Register List |
| Page | 80022 | Pallet Rental Billing Lines |
| Page | 80023 | Pallet Register Card |
| PageExt | 80026 | Customer Card |
| PageExt | 80027 | Item Card |
| PageExt | 80028 | Sales Order |

## Dependency
Requires the existing **"Storage Condition"** table/page and the Item fields
`Rent Pallet/Day`, `Customer Code`, `Storage Condition Code` from your v1 package.
Keep v1 installed, or move those objects into this app.

## How each scenario is billed (matches BILLING EXCEL v1)

**Normal Counting**
`Daily storage = Occupancy × Rate(Storage Condition)`; Management Fee added once per period.
Example: 65 × 3.75 = 243.75 + 300 mgmt on day 1.

**Fixed Locations**
`Chargeable = max(Occupancy − Allocated Locations, 0)`; `Storage = Chargeable × Rate`.
Fixed monthly charge prorated: `Fixed Monthly × DaysInMonth ÷ Base Days` (Base Days default 30,
so May = 1250 × 31/30 = 1291.67), posted once per calendar month.
Example: (20 − 10) × 4.50 = 45.00.

**Fixed Days**
Daily storage accrues like Normal. If a pallet ships before the minimum period,
a one-off **shortfall** is billed at shipment:
`Rate × (Min Days − Days In Store)` per pallet.
Example: received day 16, shipped day 19 → 4 days stored, 7-day min →
per pallet 5.50 × 3; across 34 pallets = 561.00.

> Handling / Overtime / Plug-in / Parking / DM Inspection are **event-based** charges in the
> Excel — enter them as manual Billing Lines (Charge Type = Handling / Other). They are not
> auto-derived because they don't follow a formula.

## Pallet ID structure
`Item + separator + Lot + separator + Sequence` (separator configurable in Setup, default `-`).
Uniqueness is enforced; multiple pallets from one lot get incrementing sequence numbers.
Number of pallets created from a receipt = `ROUNDUP(Received Qty ÷ Item.Qty per Pallet)`
(if Qty per Pallet = 0, the whole received lot is treated as one pallet).

## Occupancy definition
A pallet occupies a day `D` if `Received Date ≤ D` and (`not shipped` or `Shipped Date > D`).
A pallet received and shipped on the same day is not counted as occupying that day
(handle same-day in/out as a manual charge if you bill it — see open question #3).

## Install / build
1. Create an `app.json` (see `app.json.sample`) with a dependency on your v1 app (or merge).
2. `AL: Package` in VS Code, publish to the sandbox.
3. Open **Pallet Rental Setup**, set separator / base days / VAT.
4. Set **Storage Condition** rates (Ambient/Frozen/Chilled) and mark *Use for Warehouse Rents*.
5. On each Item: Storage Condition Code, Qty per Pallet, Customer Code (owner).
6. On each Customer: Pallet Billing Method + the fields that scenario needs.
7. Post lot-tracked purchase receipts → Pallet IDs appear in **Pallet Register**.
8. Run **Calc. Pallet Rental** for the period → review **Pallet Rental Billing Lines**.

## Open design questions (please confirm — see chat)
1. Is **Allocated Locations** counted per **storage condition** or across the whole customer?
   (Current code applies it per storage condition.)
2. For **Fixed Location**, does the fixed monthly charge cover a *specific* storage condition
   or the whole customer regardless of condition?
3. **Same-day in/out** — chargeable or free?
4. Should shortfall use **calendar days** (current: inclusive, `Shipped − Received + 1`)
   or **billed occupancy days**?
5. Do you want the billing lines pushed into an actual **Sales Invoice** automatically,
   or kept as a worksheet to review before invoicing?
