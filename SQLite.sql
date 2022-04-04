CREATE PROCEDURE impute_missing(
    in_table_name    IN VARCHAR2,
    in_attribute     IN VARCHAR2,
    in_impute_method IN VARCHAR2 DEFAULT ‘median’
) IS
    impute_func   VARCHAR2(16);
    get_avg_stmt  VARCHAR2(128);
    avg_value     NUMBER;
    update_stmt   VARCHAR2(128);
BEGIN
    CASE in_impute_method
        WHEN ‘mean’   THEN impute_func := ‘AVG’;
        WHEN ‘median’ THEN impute_func := ‘MEDIAN’;
        WHEN ‘mode’   THEN impute_func := ‘STATS_MODE’;
        ELSE RAISE_APPLICATION_ERROR(-20001, ‘Invalid impute method!’);
    END CASE;    get_avg_stmt :=
         q’[SELECT ]’
      || impute_func
      || q’[(]’
      || in_attribute
      || q’[) FROM ]’
      || in_table_name;
    DBMS_OUTPUT.PUT_LINE(‘get_avg_stmt = ‘ || get_avg_stmt);    BEGIN EXECUTE IMMEDIATE get_avg_stmt INTO avg_value;
    END;
    DBMS_OUTPUT.PUT_LINE(‘avg_value = ‘ || avg_value);    update_stmt :=
         q’[UPDATE ]’
      || in_table_name
      || q’[ SET ]’
      || in_attribute
      || q’[ = ]’
      || avg_value
      || q’[ WHERE ]’
      || in_attribute
      || q’[ IS NULL]’;
    DBMS_OUTPUT.PUT_LINE(‘update_stmt = ‘ || update_stmt);    BEGIN EXECUTE IMMEDIATE update_stmt;
    END;
    COMMIT;END;

             
BEGIN
    impute_missing(‘mytable’, ‘daily_vaccinations’, ‘median’);
END;
/ 