CLASS zcl_word_count_kd DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
     DATA value TYPE i.
    TYPES:
      ty_it_stopwords TYPE STANDARD TABLE OF string WITH DEFAULT KEY.
    METHODS file_upload
        IMPORTING
        iv_name TYPE string OPTIONAL
        RETURNING VALUE(rv_stopwords) TYPE ty_it_stopwords.
    METHODS counter
      IMPORTING
        iv_text TYPE string
        iv_itab TYPE STANDARD TABLE OPTIONAL
        iv_file_name TYPE string
      RETURNING
        VALUE(rv_num_of_words) TYPE integer.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_word_count_kd IMPLEMENTATION.

  METHOD counter.
    TYPES t_itab TYPE STANDARD TABLE OF string WITH EMPTY KEY.
    DATA lv_itab TYPE t_itab.
    DATA lv_itab_input TYPE t_itab.
    DATA counter TYPE i VALUE 0.

    IF  iv_itab IS INITIAL.
        lv_itab = file_upload(  ).
    ELSEIF NOT iv_file_name IS INITIAL.
        lv_itab_input = file_upload( iv_name = iv_file_name ).
    ELSE.
        SPLIT iv_text AT space INTO TABLE lv_itab_input.
        lv_itab = iv_itab.
    ENDIF.

    LOOP AT lv_itab INTO DATA(wa_lv_itab).
        LOOP AT lv_itab_input INTO DATA(wa_itab).
            IF wa_itab = wa_lv_itab.
            counter = counter + 1.
            ENDIF.
        ENDLOOP.
    ENDLOOP.
    DATA(total_words) = lines( lv_itab_input ).
    rv_num_of_words = total_words - counter.
  ENDMETHOD.


  METHOD file_upload.

*    DATA it_stopwords TYPE ty_it_stopwords.

    cl_gui_frontend_services=>gui_upload(
      EXPORTING
        filename                = 'C:\Users\k.mokashi\Desktop\stopwords.txt'
        filetype                = 'ASC'
        read_by_line            = 'X'
      CHANGING
        data_tab                = rv_stopwords
      EXCEPTIONS
        file_open_error         = 1
        file_read_error         = 2
        no_batch                = 3
        gui_refuse_filetransfer = 4
        invalid_type            = 5
        no_authority            = 6
        unknown_error           = 7
        bad_data_format         = 8
        header_not_allowed      = 9
        separator_not_allowed   = 10
        header_too_long         = 11
        unknown_dp_error        = 12
        access_denied           = 13
        dp_out_of_memory        = 14
        disk_full               = 15
        dp_timeout              = 16
        not_supported_by_gui    = 17
        error_no_gui            = 18
        OTHERS                  = 19
    ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

*    rv_stopwords = it_stopwords.

  ENDMETHOD.

ENDCLASS.
