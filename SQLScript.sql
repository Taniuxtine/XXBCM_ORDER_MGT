--------------------------------------------------------
--  File created - Monday-January-18-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence INVOICE_LINE_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "INVOICE_LINE_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence INVOICE_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "INVOICE_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence PO_LINE_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "PO_LINE_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence PO_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "PO_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence STAGE_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "STAGE_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence SUPPLIER_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "SUPPLIER_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Table INVOICE
--------------------------------------------------------

  CREATE TABLE "INVOICE" 
   (	"INVOICE_ID" NUMBER, 
	"INVOICE_REFERENCE" VARCHAR2(20), 
	"INVOICE_DATE" DATE, 
	"INVOICE_STATUS" VARCHAR2(10), 
	"INVOICE_HOLD_REASON" VARCHAR2(100)
   ) ;
--------------------------------------------------------
--  DDL for Table INVOICE_LINE
--------------------------------------------------------

  CREATE TABLE "INVOICE_LINE" 
   (	"INVOICE_LINE_ID" NUMBER, 
	"INVOICE_ID" NUMBER, 
	"INVOICE_AMOUNT" NUMBER, 
	"INVOICE_DESCRIPTION" VARCHAR2(200), 
	"PO_LINE_ID" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table PO
--------------------------------------------------------

  CREATE TABLE "PO" 
   (	"PO_ID" NUMBER, 
	"PO_REF" VARCHAR2(5), 
	"PO_DATE" DATE, 
	"SUPPLIER_ID" NUMBER(6,0), 
	"PO_TOTAL_AMOUNT" NUMBER, 
	"DESCRIPTION" VARCHAR2(150), 
	"STATUS" VARCHAR2(100)
   ) ;
--------------------------------------------------------
--  DDL for Table PO_LINE
--------------------------------------------------------

  CREATE TABLE "PO_LINE" 
   (	"PO_LINE_ID" NUMBER, 
	"PO_ID" NUMBER, 
	"PO_LINE_DESCRIPTION" VARCHAR2(200), 
	"PO_LINE_NUMBER" NUMBER, 
	"PO_LINE_STATUS" VARCHAR2(10), 
	"PO_LINE_AMOUNT" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table SUPPLIER
--------------------------------------------------------

  CREATE TABLE "SUPPLIER" 
   (	"SUPPLIER_ID" NUMBER(6,0), 
	"SUPPLIER_NAME" VARCHAR2(300), 
	"ADDRESS" VARCHAR2(500), 
	"CONTACT_NO1" VARCHAR2(10), 
	"CONTACT_NO2" VARCHAR2(10), 
	"CONTACT_PERSON" VARCHAR2(300), 
	"EMAIL_ADDRESS" VARCHAR2(100)
   ) ;
--------------------------------------------------------
--  DDL for Table XXBCM_ORDER_MGT_STAGE
--------------------------------------------------------

  CREATE TABLE "XXBCM_ORDER_MGT_STAGE" 
   (	"STAGE_ID" NUMBER, 
	"ORDER_REF" VARCHAR2(2000), 
	"ORDER_DATE" VARCHAR2(2000), 
	"SUPPLIER_NAME" VARCHAR2(2000), 
	"SUPP_CONTACT_NAME" VARCHAR2(2000), 
	"SUPP_ADDRESS" VARCHAR2(2000), 
	"SUPP_CONTACT_NUMBER" VARCHAR2(2000), 
	"SUPP_EMAIL" VARCHAR2(2000), 
	"ORDER_TOTAL_AMOUNT" VARCHAR2(2000), 
	"ORDER_DESCRIPTION" VARCHAR2(2000), 
	"ORDER_STATUS" VARCHAR2(2000), 
	"ORDER_LINE_AMOUNT" VARCHAR2(2000), 
	"INVOICE_REFERENCE" VARCHAR2(2000), 
	"INVOICE_DATE" VARCHAR2(2000), 
	"INVOICE_STATUS" VARCHAR2(2000), 
	"INVOICE_HOLD_REASON" VARCHAR2(2000), 
	"INVOICE_AMOUNT" VARCHAR2(2000), 
	"INVOICE_DESCRIPTION" VARCHAR2(2000), 
	"ORDER_LINE" NUMBER, 
	"PO_STATUS" VARCHAR2(10), 
	"PO_LINE_STATUS" VARCHAR2(10), 
	"INV_STATUS" VARCHAR2(10), 
	"INVOICE_LINE_STATUS" VARCHAR2(10), 
	"ERR_MSG" VARCHAR2(500)
   ) ;
--------------------------------------------------------
--  DDL for View PO_INVOICE_LINE_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "PO_INVOICE_LINE_V" ("PO_ID", "PO_REF", "PO_DATE", "SUPPLIER_NAME", "PO_TOTAL_AMOUNT", "DESCRIPTION", "PO_STATUS", "PO_LINE_NUMBER", "PO_LINE_DESCRIPTION", "PO_LINE_STATUS", "PO_LINE_AMOUNT", "INVOICE_REFERENCE", "INVOICE_DATE", "INVOICE_STATUS", "INVOICE_HOLD_REASON", "INVOICE_AMOUNT", "INVOICE_DESCRIPTION") AS 
  SELECT po.po_id, PO_ref, po_date, supplier_name, po_total_amount, description, status as po_status, po_line_number, po_line_description, po_line_status, po_line_amount, 
 invoice_reference, invoice_date, invoice_status, invoice_hold_reason, invoice_amount, invoice_description
 from po, po_line, supplier, invoice, invoice_line
 where po.po_id = po_line.po_id
 and po.supplier_id = supplier.supplier_id
 and po_line.po_line_id = invoice_line.po_line_id(+)
 and  invoice_line.invoice_id = invoice.invoice_id (+)
;
--------------------------------------------------------
--  DDL for View PO_V
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "PO_V" ("PO_ID", "PO_REF", "PO_DATE", "PO_TOTAL_AMOUNT", "STATUS", "SUPPLIER_NAME", "ADDRESS", "CONTACT_NO1", "CONTACT_NO2", "CONTACT_PERSON", "EMAIL_ADDRESS") AS 
  SELECT
        po_id,
        po_ref,
        po_date,
        po_total_amount,
        status,
        supplier_name,
        address,
        contact_no1,
        contact_no2,
        contact_person,
        email_address
    FROM
        po,
        supplier
    WHERE
        po.supplier_id = supplier.supplier_id
;
--------------------------------------------------------
--  DDL for Index PO_LINE_UNQ1
--------------------------------------------------------

  CREATE UNIQUE INDEX "PO_LINE_UNQ1" ON "PO_LINE" ("PO_ID", "PO_LINE_NUMBER") 
  ;
--------------------------------------------------------
--  DDL for Index PO_LINE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PO_LINE_PK" ON "PO_LINE" ("PO_LINE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index PO_UNK1
--------------------------------------------------------

  CREATE UNIQUE INDEX "PO_UNK1" ON "PO" ("PO_REF") 
  ;
--------------------------------------------------------
--  DDL for Index SUPPLIER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "SUPPLIER_PK" ON "SUPPLIER" ("SUPPLIER_ID") 
  ;
--------------------------------------------------------
--  DDL for Index UNQ1
--------------------------------------------------------

  CREATE UNIQUE INDEX "UNQ1" ON "INVOICE" ("INVOICE_REFERENCE") 
  ;
--------------------------------------------------------
--  DDL for Index PO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PO_PK" ON "PO" ("PO_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SUPPLIER_UNQ1
--------------------------------------------------------

  CREATE UNIQUE INDEX "SUPPLIER_UNQ1" ON "SUPPLIER" ("SUPPLIER_NAME") 
  ;
--------------------------------------------------------
--  DDL for Index INDEX1
--------------------------------------------------------

  CREATE UNIQUE INDEX "INDEX1" ON "INVOICE" ("INVOICE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index INVOICE_LINE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "INVOICE_LINE_PK" ON "INVOICE_LINE" ("INVOICE_LINE_ID") 
  ;
--------------------------------------------------------
--  DDL for Trigger BI_INVOICE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "BI_INVOICE" 
   before insert on "INVOICE" 
   for each row 
begin  
   if inserting then 
      if :NEW."INVOICE_ID" is null then 
         select INVOICE_SEQ.nextval into :NEW."INVOICE_ID" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "BI_INVOICE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BI_INVOICE_LINE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "BI_INVOICE_LINE" 
   before insert on "INVOICE_LINE" 
   for each row 
begin  
   if inserting then 
      if :NEW."INVOICE_LINE_ID" is null then 
         select INVOICE_LINE_SEQ.nextval into :NEW."INVOICE_LINE_ID" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "BI_INVOICE_LINE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BI_PO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "BI_PO" 
   before insert on "PO" 
   for each row 
begin  
   if inserting then 
      if :NEW."PO_ID" is null then 
         select PO_SEQ.nextval into :NEW."PO_ID" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "BI_PO" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BI_PO_LINE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "BI_PO_LINE" 
   before insert on "PO_LINE" 
   for each row 
begin  
   if inserting then 
      if :NEW."PO_LINE_ID" is null then 
         select PO_LINE_SEQ.nextval into :NEW."PO_LINE_ID" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "BI_PO_LINE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BI_STAGE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "BI_STAGE" 
   before insert on "XXBCM_ORDER_MGT_STAGE" 
   for each row 
begin  
   if inserting then 
      if :NEW."STAGE_ID" is null then 
         select STAGE_SEQ.nextval into :NEW."STAGE_ID" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "BI_STAGE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BI_SUPPLIER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "BI_SUPPLIER" 
   before insert on "SUPPLIER" 
   for each row 
begin  
   if inserting then 
      if :NEW."SUPPLIER_ID" is null then 
         select SUPPLIER_PK.nextval into :NEW."SUPPLIER_ID" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "BI_SUPPLIER" ENABLE;
--------------------------------------------------------
--  DDL for Procedure PO_INVOICE_TOTAL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PO_INVOICE_TOTAL" (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR SELECT DISTINCT
                          to_number(replace(po_ref, 'PO')) AS "Order Refence",
                          to_char(po_date, 'MON-YY') "Order Period",
                          TRIM(initcap(supplier_name)) AS "Supplier Name",
                          to_char(po_total_amount, 'FM99G999G999G999D00') AS "Order Total Amount",
                          po_status           AS "Order Status",
                          invoice_reference   AS "Invoice Reference",
                          to_char(SUM(invoice_amount), 'FM99G999G999G999D00') AS "Invoice Total Amount",
                          get_inv_status(po_id) AS "Action"
                      FROM
                          po_invoice_line_v
                      GROUP BY
                          to_number(replace(po_ref, 'PO')),
                          to_char(po_date, 'MON-YY'),
                          initcap(supplier_name),
                          to_char(po_total_amount, 'FM99G999G999G999D00'),
                          po_status,
                          invoice_reference,
                          get_inv_status(po_id)
                      ORDER BY
                          to_char(po_date, 'MON-YY') DESC;

END;

/
--------------------------------------------------------
--  DDL for Procedure SUPPLIER_SUMMARY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SUPPLIER_SUMMARY" (
    p_cursor OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN p_cursor FOR SELECT
                          supplier_name    "Supplier Name",
                          contact_person   "Supplier Contact Name",
                          to_char(contact_no1, 'fm9999g9999', 'NLS_NUMERIC_CHARACTERS=''.-''') "Supplier Contact No. 1",
                          to_char(contact_no2, 'fm9999g9999', 'NLS_NUMERIC_CHARACTERS=''.-''') "Supplier Contact No. 2",
                          COUNT(po_id) "Total Orders",
                          SUM(po_total_amount) "Order Total Amount"
                      FROM
                          po_v
                      WHERE
                          po_date BETWEEN '01-JAN-2017' AND '31-AUG-2017'
                      GROUP BY
                          supplier_name,
                          contact_person,
                          contact_no1,
                          contact_no2;

END;

/
--------------------------------------------------------
--  DDL for Procedure THIRD_HIGHEST_ORDER_AMOUNT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "THIRD_HIGHEST_ORDER_AMOUNT" (
    p_cursor OUT SYS_REFCURSOR
) IS
BEGIN
    OPEN p_cursor FOR SELECT
                          po_ref            AS "Order Reference",
                          supplier_name     AS "Supplier Name",
                          po_total_amount   AS "Order Total Amount",
                          status            AS "Order Status",
                          invoice_refs      AS "Invoice References"
                      FROM
                          (
                              SELECT
                                  to_number(replace(po_ref, 'PO')) po_ref,
                                  upper(supplier_name) supplier_name,
                                  to_char(po_total_amount, 'FM99G999G999G999D00') AS po_total_amount,
                                  status,
                                  get_all_inv(po_id) invoice_refs,
                                  RANK() OVER(
                                      ORDER BY
                                          po_total_amount DESC
                                  ) AS row_rank
                              FROM
                                  po_v
                          )
                      WHERE
                          row_rank = 3;

END;

/
--------------------------------------------------------
--  DDL for Package EXTRACTION_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "EXTRACTION_PKG" AS
    PROCEDURE EXTRACTION;
END extraction_pkg;

/
--------------------------------------------------------
--  DDL for Package Body EXTRACTION_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "EXTRACTION_PKG" AS

    PROCEDURE set_up_stage_area IS
    BEGIN
        INSERT INTO xxbcm_order_mgt_stage (
            order_ref,
            order_date,
            supplier_name,
            supp_contact_name,
            supp_address,
            supp_contact_number,
            supp_email,
            order_total_amount,
            order_description,
            order_status,
            order_line_amount,
            invoice_reference,
            invoice_date,
            invoice_status,
            invoice_hold_reason,
            invoice_amount,
            invoice_description
        )
            SELECT
                order_ref,
                order_date,
                supplier_name,
                supp_contact_name,
                supp_address,
                supp_contact_number,
                supp_email,
                order_total_amount,
                order_description,
                order_status,
                order_line_amount,
                invoice_reference,
                invoice_date,
                invoice_status,
                invoice_hold_reason,
                invoice_amount,
                invoice_description
            FROM
                xxbcm_order_mgt
            MINUS
            SELECT
                order_ref,
                order_date,
                supplier_name,
                supp_contact_name,
                supp_address,
                supp_contact_number,
                supp_email,
                order_total_amount,
                order_description,
                order_status,
                order_line_amount,
                invoice_reference,
                invoice_date,
                invoice_status,
                invoice_hold_reason,
                invoice_amount,
                invoice_description
            FROM
                xxbcm_order_mgt_stage;

    END set_up_stage_area;

    PROCEDURE extract_supplier AS
        v_supplier_id VARCHAR2(2000);
    BEGIN
        FOR c IN (
            SELECT DISTINCT
                supplier_name,
                supp_contact_name,
                supp_address,
                supp_contact_number,
                CASE
                    WHEN regexp_replace(supp_contact_number, '[^0-9,]', '') NOT LIKE '%,%' THEN
                        NULL
                    ELSE
                        regexp_substr(regexp_replace(supp_contact_number, '[^0-9,]', ''), '[^,]+$')
                END contact2,
                regexp_substr(regexp_replace(supp_contact_number, '[^0-9,]', ''), '[^,]+') contact1,
                supp_email
            FROM
                xxbcm_order_mgt_stage
            WHERE
                order_ref NOT LIKE '%-%'
        ) LOOP
            BEGIN
                SELECT
                    supplier_id
                INTO v_supplier_id
                FROM
                    supplier
                WHERE
                    TRIM(initcap(supplier_name)) = TRIM(initcap(c.supplier_name));
            
            --assumption made that more recent PO will carry updated supplier information

                UPDATE supplier
                SET
                    address = c.supp_address,
                    contact_no1 = c.contact1,
                    contact_no2 = c.contact2,
                    contact_person = c.supp_contact_name,
                    email_address = c.supp_email
                WHERE
                    supplier_id = v_supplier_id;

            EXCEPTION
                WHEN no_data_found THEN
                    INSERT INTO supplier (
                        supplier_name,
                        address,
                        contact_no1,
                        contact_no2,
                        contact_person,
                        email_address
                    ) VALUES (
                        c.supplier_name,
                        c.supp_address,
                        c.contact1,
                        c.contact2,
                        c.supp_contact_name,
                        c.supp_email
                    );

            END;
        END LOOP;
    END extract_supplier;

    FUNCTION convert_to_number (
        p_amount IN VARCHAR2
    ) RETURN NUMBER IS
        v_number NUMBER;
    BEGIN
        v_number := replace(replace(replace(replace(upper(p_amount), ',', ''), 'S', '5'), 'O', '0'), 'I', '1');

        RETURN v_number;
    END convert_to_number;

    FUNCTION convert_to_date (
        p_date IN VARCHAR2
    ) RETURN DATE IS
        v_date DATE;
    BEGIN
        BEGIN
            SELECT
                to_date(p_date, 'DD-MON-YYYY')
            INTO v_date
            FROM
                dual;

        EXCEPTION
            WHEN OTHERS THEN
                SELECT
                    to_date(p_date, 'DD-MM-YYYY')
                INTO v_date
                FROM
                    dual;

        END;

        RETURN v_date;
    END convert_to_date;

    PROCEDURE extract_purchase_order IS
        v_supplier_id          NUMBER;
        v_order_date           DATE;
        v_order_total_amount   NUMBER;
        v_po_id                NUMBER;
    BEGIN
        FOR c IN (
            SELECT
                stage_id,
                order_ref,
                order_date,
                supplier_name,
                order_total_amount,
                order_description,
                order_status,
                po_status
            FROM
                xxbcm_order_mgt_stage
            WHERE
                order_ref NOT LIKE '%-%'
            ORDER BY
                order_ref
        ) LOOP
            IF nvl(c.po_status, '!') = 'OK' THEN
                CONTINUE;
            END IF;
            BEGIN
                SELECT
                    supplier_id
                INTO v_supplier_id
                FROM
                    supplier
                WHERE
                    TRIM(initcap(supplier_name)) = TRIM(initcap(c.supplier_name));

            EXCEPTION
                WHEN no_data_found THEN
                    UPDATE xxbcm_order_mgt_stage
                    SET
                        po_status = 'ERR',
                        err_msg = 'Supplier '
                                  || c.supplier_name
                                  || ' could not be found.'
                    WHERE
                        stage_id = c.stage_id;

                    CONTINUE;
            END;

            BEGIN
                v_order_date := convert_to_date(c.order_date);
            EXCEPTION
                WHEN OTHERS THEN
                    UPDATE xxbcm_order_mgt_stage
                    SET
                        po_status = 'ERR',
                        err_msg = 'Date '
                                  || c.order_date
                                  || ' is not in a proper date format'
                    WHERE
                        stage_id = c.stage_id;

                    CONTINUE;
            END;

            BEGIN
                v_order_total_amount := convert_to_number(c.order_total_amount);
            EXCEPTION
                WHEN OTHERS THEN
                    UPDATE xxbcm_order_mgt_stage
                    SET
                        po_status = 'ERR',
                        err_msg = 'Amount '
                                  || c.order_total_amount
                                  || ' is not in a proper numeric format'
                    WHERE
                        stage_id = c.stage_id;

                    CONTINUE;
            END;

            BEGIN
                SELECT
                    po_id
                INTO v_po_id
                FROM
                    po
                WHERE
                    po_ref = c.order_ref;

                UPDATE xxbcm_order_mgt_stage
                SET
                    po_status = 'ERR',
                    err_msg = 'PO '
                              || c.order_ref
                              || ' already exists.'
                WHERE
                    stage_id = c.stage_id;

                CONTINUE;
            EXCEPTION
                WHEN no_data_found THEN
                    INSERT INTO po (
                        po_ref,
                        po_date,
                        supplier_id,
                        po_total_amount,
                        description,
                        status
                    ) VALUES (
                        c.order_ref,
                        v_order_date,
                        v_supplier_id,
                        v_order_total_amount,
                        c.order_description,
                        c.order_status
                    );

            END;

            UPDATE xxbcm_order_mgt_stage
            SET
                po_status = 'OK'
            WHERE
                stage_id = c.stage_id;

        END LOOP;
    END extract_purchase_order;

    PROCEDURE extract_lines IS

        v_order_line_amount    NUMBER;
        v_po_id                NUMBER;
        v_po_line_id           NUMBER;
        v_max_po_line_number   NUMBER;
        v_po_line_number       NUMBER;
        v_invoice_id           NUMBER;
        v_invoice_date         DATE;
        v_invoice_amount       NUMBER;
        v_chk_po_line_number   NUMBER;
        v_invoice_line_id      NUMBER;
    BEGIN
        FOR c IN (
            SELECT
                stage_id,
                order_ref,
                regexp_substr(order_ref, '[^-]+') po_ref,
                regexp_substr(order_ref, '[^-]+$') po_line,
                order_description,
                order_status,
                order_line_amount,
                invoice_reference,
                invoice_date,
                invoice_status,
                invoice_hold_reason,
                invoice_amount,
                invoice_description,
                po_line_status,
                inv_status,
                invoice_line_status,
                order_line
            FROM
                xxbcm_order_mgt_stage
            WHERE
                order_ref LIKE '%-%'
            ORDER BY
                order_ref
        ) LOOP
            IF nvl(c.po_line_status, '!') = 'OK' THEN
            --fetching po_line_id to be used by invoice_line if invoice_line has not yet been loaded
                SELECT
                    po_line_id
                INTO v_po_line_id
                FROM
                    po_line
                WHERE
                    po_id = (
                        SELECT
                            po_id
                        FROM
                            po
                        WHERE
                            po_ref = c.po_ref
                    )
                    AND po_line_number = c.order_line;

            ELSE
           --create PO
                BEGIN
                    SELECT
                        po_id
                    INTO v_po_id
                    FROM
                        po
                    WHERE
                        po_ref = c.po_ref;

                EXCEPTION
                    WHEN no_data_found THEN
                        UPDATE xxbcm_order_mgt_stage
                        SET
                            po_line_status = 'ERR',
                            err_msg = 'PO '
                                      || c.po_ref
                                      || ' has not been found'
                        WHERE
                            stage_id = c.stage_id;

                        CONTINUE;
                END;

                BEGIN
                    v_order_line_amount := convert_to_number(c.order_line_amount);
                EXCEPTION
                    WHEN OTHERS THEN
                        UPDATE xxbcm_order_mgt_stage
                        SET
                            po_line_status = 'ERR',
                            err_msg = 'Amount '
                                      || c.order_line_amount
                                      || ' is not in a proper numeric format'
                        WHERE
                            stage_id = c.stage_id;

                        CONTINUE;
                END;

                BEGIN
                    SELECT
                        po_line_number
                    INTO v_chk_po_line_number
                    FROM
                        po_line
                    WHERE
                        po_id = v_po_id
                        AND po_line_number = c.po_line;

                    SELECT
                        MAX(po_line_number)
                    INTO v_max_po_line_number
                    FROM
                        po_line
                    WHERE
                        po_id = v_po_id;

                    v_po_line_number := v_max_po_line_number + 1;
                EXCEPTION
                    WHEN no_data_found THEN
                        v_po_line_number := to_number(c.po_line);
                END;

                UPDATE xxbcm_order_mgt_stage
                SET
                    order_line = v_po_line_number
                WHERE
                    stage_id = c.stage_id;

                SELECT
                    po_line_seq.NEXTVAL
                INTO v_po_line_id
                FROM
                    dual;

                INSERT INTO po_line (
                    po_line_id,
                    po_id,
                    po_line_description,
                    po_line_number,
                    po_line_status,
                    po_line_amount
                ) VALUES (
                    v_po_line_id,
                    v_po_id,
                    c.order_description,
                    v_po_line_number,
                    c.order_status,
                    v_order_line_amount
                );

                UPDATE xxbcm_order_mgt_stage
                SET
                    po_line_status = 'OK'
                WHERE
                    stage_id = c.stage_id;

            END IF;

            IF nvl(c.inv_status, '!') = 'OK' THEN
         --fetching invoice_id to be used by invoice_line if invoice_line has not yet been loaded
                SELECT
                    invoice_id
                INTO v_invoice_id
                FROM
                    invoice
                WHERE
                    invoice_reference = c.invoice_reference;

            ELSE
                IF c.invoice_reference IS NOT NULL THEN
               --creating invoice
                    BEGIN
                        SELECT
                            invoice_id
                        INTO v_invoice_id
                        FROM
                            invoice
                        WHERE
                            invoice_reference = c.invoice_reference;

                    EXCEPTION
                        WHEN no_data_found THEN
                            BEGIN
                                v_invoice_date := convert_to_date(c.invoice_date);
                            EXCEPTION
                                WHEN OTHERS THEN
                                    UPDATE xxbcm_order_mgt_stage
                                    SET
                                        inv_status = 'ERR',
                                        err_msg = 'Date '
                                                  || c.invoice_date
                                                  || ' is not in a proper date format'
                                    WHERE
                                        stage_id = c.stage_id;

                                    CONTINUE;
                            END;

                            SELECT
                                invoice_seq.NEXTVAL
                            INTO v_invoice_id
                            FROM
                                dual;

                            INSERT INTO invoice (
                                invoice_id,
                                invoice_reference,
                                invoice_date,
                                invoice_status,
                                invoice_hold_reason
                            ) VALUES (
                                v_invoice_id,
                                c.invoice_reference,
                                v_invoice_date,
                                c.invoice_status,
                                c.invoice_hold_reason
                            );

                            UPDATE xxbcm_order_mgt_stage
                            SET
                                inv_status = 'OK'
                            WHERE
                                stage_id = c.stage_id;

                    END;

                    IF nvl(c.invoice_line_status, '!') != 'OK' THEN
                  --creating invoice_line
                        BEGIN
                            v_invoice_amount := convert_to_number(c.invoice_amount);
                        EXCEPTION
                            WHEN OTHERS THEN
                                UPDATE xxbcm_order_mgt_stage
                                SET
                                    invoice_line_status = 'ERR',
                                    err_msg = 'Amount '
                                              || c.invoice_amount
                                              || ' is not in a proper numeric format'
                                WHERE
                                    stage_id = c.stage_id;

                                CONTINUE;
                        END;

                        BEGIN
                            SELECT
                                invoice_line_id                                                                                       -- kind of redundant
                            INTO v_invoice_line_id
                            FROM
                                invoice_line
                            WHERE
                                invoice_id = v_invoice_id
                                AND invoice_description = c.invoice_description
                                AND invoice_amount = v_invoice_amount;

                            CONTINUE;
                        EXCEPTION
                            WHEN no_data_found THEN
                                INSERT INTO invoice_line (
                                    invoice_id,
                                    invoice_amount,
                                    invoice_description,
                                    po_line_id
                                ) VALUES (
                                    v_invoice_id,
                                    v_invoice_amount,
                                    c.invoice_description,
                                    v_po_line_id
                                );

                                UPDATE xxbcm_order_mgt_stage
                                SET
                                    invoice_line_status = 'OK'
                                WHERE
                                    stage_id = c.stage_id;

                        END;

                    END IF;

                END IF;
            END IF;

        END LOOP;
    END extract_lines;

    PROCEDURE extraction AS
    BEGIN
        set_up_stage_area;
        extract_supplier;
        extract_purchase_order;
        extract_lines;
    END extraction;

END extraction_pkg;

/
--------------------------------------------------------
--  DDL for Function GET_ALL_INV
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "GET_ALL_INV" (
    p_po_id IN NUMBER
) RETURN VARCHAR2 IS
    v_invoice_reference   VARCHAR2(1000);
    v_count               NUMBER := 0;
BEGIN
    FOR c IN (
        SELECT
            distinct invoice_reference
        FROM
            po_invoice_line_v
        WHERE
            invoice_reference IS NOT NULL
            AND po_id = p_po_id order by invoice_reference
    ) LOOP
        IF v_count = 0 THEN
            v_invoice_reference := c.invoice_reference;
        ELSE
            v_invoice_reference := v_invoice_reference
                                   || ','
                                   || c.invoice_reference;
        END IF;

        v_count := v_count + 1;
    END LOOP;

    RETURN v_invoice_reference;
END;

/
--------------------------------------------------------
--  DDL for Function GET_INV_STATUS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "GET_INV_STATUS" (
    p_po_id IN NUMBER
) RETURN VARCHAR2 IS
    v_paid      NUMBER;
    v_pending   NUMBER;
    v_unknown   NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO v_paid
    FROM
        po_invoice_line_v
    WHERE
        po_id = p_po_id
        AND nvl(invoice_status, '!') = 'Paid';

    SELECT
        COUNT(*)
    INTO v_pending
    FROM
        po_invoice_line_v
    WHERE
        po_id = p_po_id
        AND nvl(invoice_status, '!') = 'Pending';

    SELECT
        COUNT(*)
    INTO v_unknown
    FROM
        po_invoice_line_v
    WHERE
        po_id = p_po_id
        AND invoice_status IS NULL;

    IF v_unknown > 0 THEN
        RETURN 'To verify';
    ELSIF v_pending > 0 THEN
        RETURN 'To follow up';
    ELSE
        RETURN 'OK';
    END IF;

END get_inv_status;

/
--------------------------------------------------------
--  Constraints for Table INVOICE_LINE
--------------------------------------------------------

  ALTER TABLE "INVOICE_LINE" MODIFY ("INVOICE_LINE_ID" NOT NULL ENABLE);
  ALTER TABLE "INVOICE_LINE" MODIFY ("INVOICE_ID" NOT NULL ENABLE);
  ALTER TABLE "INVOICE_LINE" MODIFY ("INVOICE_AMOUNT" NOT NULL ENABLE);
  ALTER TABLE "INVOICE_LINE" MODIFY ("PO_LINE_ID" NOT NULL ENABLE);
  ALTER TABLE "INVOICE_LINE" ADD CONSTRAINT "INVOICE_LINE_PK" PRIMARY KEY ("INVOICE_LINE_ID")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table PO
--------------------------------------------------------

  ALTER TABLE "PO" MODIFY ("PO_ID" NOT NULL ENABLE);
  ALTER TABLE "PO" MODIFY ("PO_REF" NOT NULL ENABLE);
  ALTER TABLE "PO" MODIFY ("PO_DATE" NOT NULL ENABLE);
  ALTER TABLE "PO" MODIFY ("SUPPLIER_ID" NOT NULL ENABLE);
  ALTER TABLE "PO" MODIFY ("PO_TOTAL_AMOUNT" NOT NULL ENABLE);
  ALTER TABLE "PO" MODIFY ("DESCRIPTION" NOT NULL ENABLE);
  ALTER TABLE "PO" MODIFY ("STATUS" NOT NULL ENABLE);
  ALTER TABLE "PO" ADD CONSTRAINT "PO_PK" PRIMARY KEY ("PO_ID")
  USING INDEX  ENABLE;
  ALTER TABLE "PO" ADD CONSTRAINT "PO_CHK1" CHECK (STATUS IN ('Open','Closed')) ENABLE;
--------------------------------------------------------
--  Constraints for Table PO_LINE
--------------------------------------------------------

  ALTER TABLE "PO_LINE" MODIFY ("PO_LINE_ID" NOT NULL ENABLE);
  ALTER TABLE "PO_LINE" MODIFY ("PO_ID" NOT NULL ENABLE);
  ALTER TABLE "PO_LINE" MODIFY ("PO_LINE_DESCRIPTION" NOT NULL ENABLE);
  ALTER TABLE "PO_LINE" MODIFY ("PO_LINE_NUMBER" NOT NULL ENABLE);
  ALTER TABLE "PO_LINE" MODIFY ("PO_LINE_STATUS" NOT NULL ENABLE);
  ALTER TABLE "PO_LINE" MODIFY ("PO_LINE_AMOUNT" NOT NULL ENABLE);
  ALTER TABLE "PO_LINE" ADD CONSTRAINT "PO_LINE_PK" PRIMARY KEY ("PO_LINE_ID")
  USING INDEX  ENABLE;
  ALTER TABLE "PO_LINE" ADD CONSTRAINT "PO_LINE_CHK1" CHECK (PO_LINE_STATUS IN ('Received','Cancelled')) ENABLE;
  ALTER TABLE "PO_LINE" ADD CONSTRAINT "PO_LINE_UNQ1" UNIQUE ("PO_ID", "PO_LINE_NUMBER")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table SUPPLIER
--------------------------------------------------------

  ALTER TABLE "SUPPLIER" MODIFY ("SUPPLIER_ID" NOT NULL ENABLE);
  ALTER TABLE "SUPPLIER" MODIFY ("SUPPLIER_NAME" NOT NULL ENABLE);
  ALTER TABLE "SUPPLIER" MODIFY ("ADDRESS" NOT NULL ENABLE);
  ALTER TABLE "SUPPLIER" MODIFY ("CONTACT_NO1" NOT NULL ENABLE);
  ALTER TABLE "SUPPLIER" ADD CONSTRAINT "SUPPLIER_PK" PRIMARY KEY ("SUPPLIER_ID")
  USING INDEX  ENABLE;
  ALTER TABLE "SUPPLIER" MODIFY ("CONTACT_PERSON" NOT NULL ENABLE);
  ALTER TABLE "SUPPLIER" MODIFY ("EMAIL_ADDRESS" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table INVOICE
--------------------------------------------------------

  ALTER TABLE "INVOICE" ADD CONSTRAINT "INVOICE_CHK1" CHECK (INVOICE_STATUS IN ('Paid','Pending')) ENABLE;
  ALTER TABLE "INVOICE" MODIFY ("INVOICE_ID" NOT NULL ENABLE);
  ALTER TABLE "INVOICE" MODIFY ("INVOICE_REFERENCE" NOT NULL ENABLE);
  ALTER TABLE "INVOICE" MODIFY ("INVOICE_DATE" NOT NULL ENABLE);
  ALTER TABLE "INVOICE" ADD CONSTRAINT "INVOICE_PK" PRIMARY KEY ("INVOICE_ID")
  USING INDEX (CREATE UNIQUE INDEX "INDEX1" ON "INVOICE" ("INVOICE_ID") 
  )  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table INVOICE_LINE
--------------------------------------------------------

  ALTER TABLE "INVOICE_LINE" ADD CONSTRAINT "INVOICE_LINE_FK1" FOREIGN KEY ("INVOICE_ID")
	  REFERENCES "INVOICE" ("INVOICE_ID") ENABLE;
  ALTER TABLE "INVOICE_LINE" ADD CONSTRAINT "INVOICE_LINE_FK2" FOREIGN KEY ("PO_LINE_ID")
	  REFERENCES "PO_LINE" ("PO_LINE_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PO
--------------------------------------------------------

  ALTER TABLE "PO" ADD CONSTRAINT "PO_PK1" FOREIGN KEY ("SUPPLIER_ID")
	  REFERENCES "SUPPLIER" ("SUPPLIER_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PO_LINE
--------------------------------------------------------

  ALTER TABLE "PO_LINE" ADD CONSTRAINT "PO_LINE_FK1" FOREIGN KEY ("PO_ID")
	  REFERENCES "PO" ("PO_ID") ENABLE;
