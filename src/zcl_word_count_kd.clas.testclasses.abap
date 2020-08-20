CLASS zcl_word_count_kd_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA cut TYPE REF TO zcl_word_count_kd.

    METHODS:
      setup,
      test_two_words FOR TESTING RAISING cx_static_check,
      test_no_words FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS zcl_word_count_kd_test IMPLEMENTATION.



  METHOD setup.
    cut = NEW zcl_word_count_kd(  ).
  ENDMETHOD.

  METHOD test_two_words.
    cl_abap_unit_assert=>assert_equals( msg = 'Count two words' exp = 2 act = cut->counter( 'first sentence' ) ).
  ENDMETHOD.


  METHOD test_no_words.
    cl_abap_unit_assert=>assert_equals( msg = 'No words entered' exp = 0 act = cut->counter( '' ) ).
  ENDMETHOD.

ENDCLASS.
