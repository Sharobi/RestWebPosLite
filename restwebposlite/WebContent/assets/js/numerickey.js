$(document).ready(function(){
      $('#cashtenderAmt').click(function(){
    	  $('#n_keypad').fadeToggle('fast');
      });
      $('#done').click(function(){
          $('#n_keypad').hide('fast');
          getChangeAmt($('#cashtenderAmt').val());
      });
      $('#numero1').click(function(){
        if (!isNaN($('#cashtenderAmt').val())) {
           if (parseInt($('#cashtenderAmt').val()) == 0) {
             $('#cashtenderAmt').val($(this).text());
           } else {
             $('#cashtenderAmt').val($('#cashtenderAmt').val() + $(this).text());
           }
        }
      });
      $('#numero2').click(function(){
          if (!isNaN($('#cashtenderAmt').val())) {
             if (parseInt($('#cashtenderAmt').val()) == 0) {
               $('#cashtenderAmt').val($(this).text());
             } else {
               $('#cashtenderAmt').val($('#cashtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numero3').click(function(){
          if (!isNaN($('#cashtenderAmt').val())) {
             if (parseInt($('#cashtenderAmt').val()) == 0) {
               $('#cashtenderAmt').val($(this).text());
             } else {
               $('#cashtenderAmt').val($('#cashtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numero4').click(function(){
          if (!isNaN($('#cashtenderAmt').val())) {
             if (parseInt($('#cashtenderAmt').val()) == 0) {
               $('#cashtenderAmt').val($(this).text());
             } else {
               $('#cashtenderAmt').val($('#cashtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numero5').click(function(){
          if (!isNaN($('#cashtenderAmt').val())) {
             if (parseInt($('#cashtenderAmt').val()) == 0) {
               $('#cashtenderAmt').val($(this).text());
             } else {
               $('#cashtenderAmt').val($('#cashtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numero6').click(function(){
          if (!isNaN($('#cashtenderAmt').val())) {
             if (parseInt($('#cashtenderAmt').val()) == 0) {
               $('#cashtenderAmt').val($(this).text());
             } else {
               $('#cashtenderAmt').val($('#cashtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numero7').click(function(){
          if (!isNaN($('#cashtenderAmt').val())) {
             if (parseInt($('#cashtenderAmt').val()) == 0) {
               $('#cashtenderAmt').val($(this).text());
             } else {
               $('#cashtenderAmt').val($('#cashtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numero8').click(function(){
          if (!isNaN($('#cashtenderAmt').val())) {
             if (parseInt($('#cashtenderAmt').val()) == 0) {
               $('#cashtenderAmt').val($(this).text());
             } else {
               $('#cashtenderAmt').val($('#cashtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numero9').click(function(){
          if (!isNaN($('#cashtenderAmt').val())) {
             if (parseInt($('#cashtenderAmt').val()) == 0) {
               $('#cashtenderAmt').val($(this).text());
             } else {
               $('#cashtenderAmt').val($('#cashtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numerodot').click(function(){
          if (!isNaN($('#cashtenderAmt').val())) {
             if (parseInt($('#cashtenderAmt').val()) == 0) {
               $('#cashtenderAmt').val($(this).text());
             } else {
               $('#cashtenderAmt').val($('#cashtenderAmt').val() + $(this).text().trim());
             }
          }
        });
      $('.neg').click(function(){
          if (!isNaN($('#cashtenderAmt').val()) && $('#cashtenderAmt').val().length > 0) {
            if (parseInt($('#cashtenderAmt').val()) > 0) {
              $('#cashtenderAmt').val(parseInt($('#cashtenderAmt').val()) - 1);
            }
          }
      });
      $('.pos').click(function(){
          if (!isNaN($('#cashtenderAmt').val()) && $('#cashtenderAmt').val().length > 0) {
            $('#cashtenderAmt').val(parseInt($('#cashtenderAmt').val()) + 1);
          }
      });
      $('#del').click(function(){
          $('#cashtenderAmt').val($('#cashtenderAmt').val().substring(0,$('#cashtenderAmt').val().length - 1));
      });
      $('#clear').click(function(){
          $('#cashtenderAmt').val('');
      });
      $('#zero').click(function(){
        if (!isNaN($('#cashtenderAmt').val())) {
          if (parseInt($('#cashtenderAmt').val()) != 0) {
            $('#cashtenderAmt').val($('#cashtenderAmt').val() + $(this).text());
          }
        }
      });
      $('#numero100').click(function(){
          if (!isNaN($('#cashtenderAmt').val())) {
             if ($('#cashtenderAmt').val() == '') {
               $('#cashtenderAmt').val(100);
             } else {
               $('#cashtenderAmt').val(parseInt($('#cashtenderAmt').val()) + 100);
             }
          }
        });
      $('#numero50').click(function(){
          if (!isNaN($('#cashtenderAmt').val())) {
             if ($('#cashtenderAmt').val() == '') {
               $('#cashtenderAmt').val(50);
             } else {
               $('#cashtenderAmt').val(parseInt($('#cashtenderAmt').val()) + 50);
             }
          }
        });
      $('#numero20').click(function(){
          if (!isNaN($('#cashtenderAmt').val())) {
             if ($('#cashtenderAmt').val() == '') {
               $('#cashtenderAmt').val(20);
             } else {
               $('#cashtenderAmt').val(parseInt($('#cashtenderAmt').val()) + 20);
             }
          }
        });
      $('#numero10').click(function(){
          if (!isNaN($('#cashtenderAmt').val())) {
             if ($('#cashtenderAmt').val() == '') {
               $('#cashtenderAmt').val(10);
             } else {
               $('#cashtenderAmt').val(parseInt($('#cashtenderAmt').val()) + 10);
             }
          }
        });
      $('#numerorm5').click(function(){
          if (!isNaN($('#cashtenderAmt').val())) {
             if ($('#cashtenderAmt').val() == '') {
               $('#cashtenderAmt').val(5);
             } else {
               $('#cashtenderAmt').val(parseInt($('#cashtenderAmt').val()) + 5);
             }
          }
        });
      // for card 
      $('#cardlastfourDigit').click(function(){
    	  
          $('#n_keypad_cr').fadeToggle('fast');
          $('#n_keypad_cr1').hide('fast');
      });
      $('#done_cr').click(function(){
          $('#n_keypad_cr').hide('fast');
      });
      $('#numero1_cr').click(function(){
        if (!isNaN($('#cardlastfourDigit').val())) {
           if (parseInt($('#cardlastfourDigit').val()) == 0) {
             $('#cardlastfourDigit').val($(this).text());
           } else {
             $('#cardlastfourDigit').val($('#cardlastfourDigit').val() + $(this).text());
           }
        }
      });
      $('#numero2_cr').click(function(){
          if (!isNaN($('#cardlastfourDigit').val())) {
             if (parseInt($('#cardlastfourDigit').val()) == 0) {
               $('#cardlastfourDigit').val($(this).text());
             } else {
               $('#cardlastfourDigit').val($('#cardlastfourDigit').val() + $(this).text());
             }
          }
        });
      $('#numero3_cr').click(function(){
          if (!isNaN($('#cardlastfourDigit').val())) {
             if (parseInt($('#cardlastfourDigit').val()) == 0) {
               $('#cardlastfourDigit').val($(this).text());
             } else {
               $('#cardlastfourDigit').val($('#cardlastfourDigit').val() + $(this).text());
             }
          }
        });
      $('#numero4_cr').click(function(){
          if (!isNaN($('#cardlastfourDigit').val())) {
             if (parseInt($('#cardlastfourDigit').val()) == 0) {
               $('#cardlastfourDigit').val($(this).text());
             } else {
               $('#cardlastfourDigit').val($('#cardlastfourDigit').val() + $(this).text());
             }
          }
        });
      $('#numero5_cr').click(function(){
          if (!isNaN($('#cardlastfourDigit').val())) {
             if (parseInt($('#cardlastfourDigit').val()) == 0) {
               $('#cardlastfourDigit').val($(this).text());
             } else {
               $('#cardlastfourDigit').val($('#cardlastfourDigit').val() + $(this).text());
             }
          }
        });
      $('#numero6_cr').click(function(){
          if (!isNaN($('#cardlastfourDigit').val())) {
             if (parseInt($('#cardlastfourDigit').val()) == 0) {
               $('#cardlastfourDigit').val($(this).text());
             } else {
               $('#cardlastfourDigit').val($('#cardlastfourDigit').val() + $(this).text());
             }
          }
        });
      $('#numero7_cr').click(function(){
          if (!isNaN($('#cardlastfourDigit').val())) {
             if (parseInt($('#cardlastfourDigit').val()) == 0) {
               $('#cardlastfourDigit').val($(this).text());
             } else {
               $('#cardlastfourDigit').val($('#cardlastfourDigit').val() + $(this).text());
             }
          }
        });
      $('#numero8_cr').click(function(){
          if (!isNaN($('#cardlastfourDigit').val())) {
             if (parseInt($('#cardlastfourDigit').val()) == 0) {
               $('#cardlastfourDigit').val($(this).text());
             } else {
               $('#cardlastfourDigit').val($('#cardlastfourDigit').val() + $(this).text());
             }
          }
        });
      $('#numero9_cr').click(function(){
          if (!isNaN($('#cardlastfourDigit').val())) {
             if (parseInt($('#cardlastfourDigit').val()) == 0) {
               $('#cardlastfourDigit').val($(this).text());
             } else {
               $('#cardlastfourDigit').val($('#cardlastfourDigit').val() + $(this).text());
             }
          }
        });
      $('#numerodot_cr').click(function(){
          if (!isNaN($('#cardlastfourDigit').val())) {
             if (parseInt($('#cardlastfourDigit').val()) == 0) {
               $('#cardlastfourDigit').val($(this).text());
             } else {
               $('#cardlastfourDigit').val($('#cardlastfourDigit').val() + $(this).text().trim());
             }
          }
        });
      $('.neg_cr').click(function(){
          if (!isNaN($('#cardlastfourDigit').val()) && $('#cardlastfourDigit').val().length > 0) {
            if (parseInt($('#cardlastfourDigit').val()) > 0) {
              $('#cashtenderAmt').val(parseInt($('#cashtenderAmt').val()) - 1);
            }
          }
      });
      $('.pos_cr').click(function(){
          if (!isNaN($('#cardlastfourDigit').val()) && $('#cardlastfourDigit').val().length > 0) {
            $('#cardlastfourDigit').val(parseInt($('#cardlastfourDigit').val()) + 1);
          }
      });
      $('#del_cr').click(function(){
          $('#cardlastfourDigit').val($('#cardlastfourDigit').val().substring(0,$('#cardlastfourDigit').val().length - 1));
      });
      $('#clear_cr').click(function(){
          $('#cardlastfourDigit').val('');
      });
      $('#zero_cr').click(function(){
        if (!isNaN($('#cardlastfourDigit').val())) {
          if (parseInt($('#cardlastfourDigit').val()) != 0) {
            $('#cardlastfourDigit').val($('#cardlastfourDigit').val() + $(this).text());
          }
        }
      });
      /////////////
      
$('#cardtenderAmt').click(function(){
    	  
          $('#n_keypad_cr1').fadeToggle('fast');
          $('#n_keypad_cr').hide('fast');
      });
      $('#done_cr1').click(function(){
          $('#n_keypad_cr1').hide('fast');
      });
      $('#numero1_cr1').click(function(){
        if (!isNaN($('#cardtenderAmt').val())) {
           if (parseInt($('#cardtenderAmt').val()) == 0) {
             $('#cardtenderAmt').val($(this).text());
           } else {
             $('#cardtenderAmt').val($('#cardtenderAmt').val() + $(this).text());
           }
        }
      });
      $('#numero2_cr1').click(function(){
          if (!isNaN($('#cardtenderAmt').val())) {
             if (parseInt($('#cardtenderAmt').val()) == 0) {
               $('#cardtenderAmt').val($(this).text());
             } else {
               $('#cardtenderAmt').val($('#cardtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numero3_cr1').click(function(){
          if (!isNaN($('#cardtenderAmt').val())) {
             if (parseInt($('#cardtenderAmt').val()) == 0) {
               $('#cardtenderAmt').val($(this).text());
             } else {
               $('#cardtenderAmt').val($('#cardtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numero4_cr1').click(function(){
          if (!isNaN($('#cardtenderAmt').val())) {
             if (parseInt($('#cardtenderAmt').val()) == 0) {
               $('#cardtenderAmt').val($(this).text());
             } else {
               $('#cardtenderAmt').val($('#cardtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numero5_cr1').click(function(){
          if (!isNaN($('#cardtenderAmt').val())) {
             if (parseInt($('#cardtenderAmt').val()) == 0) {
               $('#cardtenderAmt').val($(this).text());
             } else {
               $('#cardtenderAmt').val($('#cardtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numero6_cr1').click(function(){
          if (!isNaN($('#cardtenderAmt').val())) {
             if (parseInt($('#cardtenderAmt').val()) == 0) {
               $('#cardtenderAmt').val($(this).text());
             } else {
               $('#cardtenderAmt').val($('#cardtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numero7_cr1').click(function(){
          if (!isNaN($('#cardtenderAmt').val())) {
             if (parseInt($('#cardtenderAmt').val()) == 0) {
               $('#cardtenderAmt').val($(this).text());
             } else {
               $('#cardtenderAmt').val($('#cardtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numero8_cr1').click(function(){
          if (!isNaN($('#cardtenderAmt').val())) {
             if (parseInt($('#cardtenderAmt').val()) == 0) {
               $('#cardtenderAmt').val($(this).text());
             } else {
               $('#cardtenderAmt').val($('#cardtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numero9_cr1').click(function(){
          if (!isNaN($('#cardtenderAmt').val())) {
             if (parseInt($('#cardtenderAmt').val()) == 0) {
               $('#cardtenderAmt').val($(this).text());
             } else {
               $('#cardtenderAmt').val($('#cardtenderAmt').val() + $(this).text());
             }
          }
        });
      $('#numerodot_cr1').click(function(){
          if (!isNaN($('#cardtenderAmt').val())) {
             if (parseInt($('#cardtenderAmt').val()) == 0) {
               $('#cardtenderAmt').val($(this).text());
             } else {
               $('#cardtenderAmt').val($('#cardtenderAmt').val() + $(this).text().trim());
             }
          }
        });
      $('.neg_cr1').click(function(){
          if (!isNaN($('#cardtenderAmt').val()) && $('#cardtenderAmt').val().length > 0) {
            if (parseInt($('#cardtenderAmt').val()) > 0) {
              $('#cardtenderAmt').val(parseInt($('#cardtenderAmt').val()) - 1);
            }
          }
      });
      $('.pos_cr1').click(function(){
          if (!isNaN($('#cardtenderAmt').val()) && $('#cardtenderAmt').val().length > 0) {
            $('#cardtenderAmt').val(parseInt($('#cardtenderAmt').val()) + 1);
          }
      });
      $('#del_cr1').click(function(){
          $('#cardtenderAmt').val($('#cardtenderAmt').val().substring(0,$('#cardtenderAmt').val().length - 1));
      });
      $('#clear_cr1').click(function(){
          $('#cardtenderAmt').val('');
      });
      $('#zero_cr1').click(function(){
        if (!isNaN($('#cardtenderAmt').val())) {
          if (parseInt($('#cardtenderAmt').val()) != 0) {
            $('#cardtenderAmt').val($('#cardtenderAmt').val() + $(this).text());
          }
        }
      });
      // for no of pax
      
      $('#noofPax').click(function(){
          	  
                $('#n_keypad_px').fadeToggle('fast');
            });
            $('#done_px').click(function(){
                $('#n_keypad_px').hide('fast');
                //getChangeAmt($('#noofPax').val());
            });
            $('#numero1_px').click(function(){
              if (!isNaN($('#noofPax').val())) {
                 if (parseInt($('#noofPax').val()) == 0) {
                   $('#noofPax').val($(this).text());
                 } else {
                   $('#noofPax').val($('#noofPax').val() + $(this).text());
                 }
              }
            });
            $('#numero2_px').click(function(){
                if (!isNaN($('#noofPax').val())) {
                   if (parseInt($('#noofPax').val()) == 0) {
                     $('#noofPax').val($(this).text());
                   } else {
                     $('#noofPax').val($('#noofPax').val() + $(this).text());
                   }
                }
              });
            $('#numero3_px').click(function(){
                if (!isNaN($('#noofPax').val())) {
                   if (parseInt($('#noofPax').val()) == 0) {
                     $('#noofPax').val($(this).text());
                   } else {
                     $('#noofPax').val($('#noofPax').val() + $(this).text());
                   }
                }
              });
            $('#numero4_px').click(function(){
                if (!isNaN($('#noofPax').val())) {
                   if (parseInt($('#noofPax').val()) == 0) {
                     $('#noofPax').val($(this).text());
                   } else {
                     $('#noofPax').val($('#noofPax').val() + $(this).text());
                   }
                }
              });
            $('#numero5_px').click(function(){
                if (!isNaN($('#noofPax').val())) {
                   if (parseInt($('#noofPax').val()) == 0) {
                     $('#noofPax').val($(this).text());
                   } else {
                     $('#noofPax').val($('#noofPax').val() + $(this).text());
                   }
                }
              });
            $('#numero6_px').click(function(){
                if (!isNaN($('#noofPax').val())) {
                   if (parseInt($('#noofPax').val()) == 0) {
                     $('#noofPax').val($(this).text());
                   } else {
                     $('#noofPax').val($('#noofPax').val() + $(this).text());
                   }
                }
              });
            $('#numero7_px').click(function(){
                if (!isNaN($('#noofPax').val())) {
                   if (parseInt($('#noofPax').val()) == 0) {
                     $('#noofPax').val($(this).text());
                   } else {
                     $('#noofPax').val($('#noofPax').val() + $(this).text());
                   }
                }
              });
            $('#numero8_px').click(function(){
                if (!isNaN($('#noofPax').val())) {
                   if (parseInt($('#noofPax').val()) == 0) {
                     $('#noofPax').val($(this).text());
                   } else {
                     $('#noofPax').val($('#noofPax').val() + $(this).text());
                   }
                }
              });
            $('#numero9_px').click(function(){
                if (!isNaN($('#noofPax').val())) {
                   if (parseInt($('#noofPax').val()) == 0) {
                     $('#noofPax').val($(this).text());
                   } else {
                     $('#noofPax').val($('#noofPax').val() + $(this).text());
                   }
                }
              });
//            $('#numerodot_px').click(function(){
//                if (!isNaN($('#noofPax').val())) {
//                   if (parseInt($('#noofPax').val()) == 0) {
//                     $('#noofPax').val($(this).text());
//                   } else {
//                     $('#noofPax').val($('#noofPax').val() + $(this).text().trim());
//                   }
//                }
//              });
            $('.neg').click(function(){
                if (!isNaN($('#noofPax').val()) && $('#noofPax').val().length > 0) {
                  if (parseInt($('#noofPax').val()) > 0) {
                    $('#noofPax').val(parseInt($('#noofPax').val()) - 1);
                  }
                }
            });
            $('.pos').click(function(){
                if (!isNaN($('#noofPax').val()) && $('#noofPax').val().length > 0) {
                  $('#noofPax').val(parseInt($('#noofPax').val()) + 1);
                }
            });
            $('#del_px').click(function(){
                $('#noofPax').val($('#noofPax').val().substring(0,$('#noofPax').val().length - 1));
            });
            $('#clear_px').click(function(){
                $('#noofPax').val('');
            });
            $('#zero_px').click(function(){
              if (!isNaN($('#noofPax').val())) {
                if (parseInt($('#noofPax').val()) != 0) {
                  $('#noofPax').val($('#noofPax').val() + $(this).text());
                }
              }
            });
            // for split bill
            
            $('#noofsplitBill').click(function(){
                	  
                      $('#n_keypad_sp').fadeToggle('fast');
                  });
                  $('#done_sp').click(function(){
                      $('#n_keypad_sp').hide('fast');
                      //getChangeAmt($('#noofPax').val());
                  });
                  $('#numero1_sp').click(function(){
                    if (!isNaN($('#noofsplitBill').val())) {
                       if (parseInt($('#noofsplitBill').val()) == 0) {
                         $('#noofsplitBill').val($(this).text());
                       } else {
                         $('#noofsplitBill').val($('#noofsplitBill').val() + $(this).text());
                       }
                    }
                  });
                  $('#numero2_sp').click(function(){
                      if (!isNaN($('#noofsplitBill').val())) {
                         if (parseInt($('#noofsplitBill').val()) == 0) {
                           $('#noofsplitBill').val($(this).text());
                         } else {
                           $('#noofsplitBill').val($('#noofsplitBill').val() + $(this).text());
                         }
                      }
                    });
                  $('#numero3_sp').click(function(){
                      if (!isNaN($('#noofsplitBill').val())) {
                         if (parseInt($('#noofsplitBill').val()) == 0) {
                           $('#noofsplitBill').val($(this).text());
                         } else {
                           $('#noofsplitBill').val($('#noofsplitBill').val() + $(this).text());
                         }
                      }
                    });
                  $('#numero4_sp').click(function(){
                      if (!isNaN($('#noofsplitBill').val())) {
                         if (parseInt($('#noofsplitBill').val()) == 0) {
                           $('#noofsplitBill').val($(this).text());
                         } else {
                           $('#noofsplitBill').val($('#noofsplitBill').val() + $(this).text());
                         }
                      }
                    });
                  $('#numero5_sp').click(function(){
                      if (!isNaN($('#noofsplitBill').val())) {
                         if (parseInt($('#noofsplitBill').val()) == 0) {
                           $('#noofsplitBill').val($(this).text());
                         } else {
                           $('#noofsplitBill').val($('#noofsplitBill').val() + $(this).text());
                         }
                      }
                    });
                  $('#numero6_sp').click(function(){
                      if (!isNaN($('#noofsplitBill').val())) {
                         if (parseInt($('#noofsplitBill').val()) == 0) {
                           $('#noofsplitBill').val($(this).text());
                         } else {
                           $('#noofsplitBill').val($('#noofsplitBill').val() + $(this).text());
                         }
                      }
                    });
                  $('#numero7_sp').click(function(){
                      if (!isNaN($('#noofsplitBill').val())) {
                         if (parseInt($('#noofsplitBill').val()) == 0) {
                           $('#noofsplitBill').val($(this).text());
                         } else {
                           $('#noofsplitBill').val($('#noofsplitBill').val() + $(this).text());
                         }
                      }
                    });
                  $('#numero8_sp').click(function(){
                      if (!isNaN($('#noofsplitBill').val())) {
                         if (parseInt($('#noofsplitBill').val()) == 0) {
                           $('#noofsplitBill').val($(this).text());
                         } else {
                           $('#noofsplitBill').val($('#noofsplitBill').val() + $(this).text());
                         }
                      }
                    });
                  $('#numero9_sp').click(function(){
                      if (!isNaN($('#noofsplitBill').val())) {
                         if (parseInt($('#noofsplitBill').val()) == 0) {
                           $('#noofsplitBill').val($(this).text());
                         } else {
                           $('#noofsplitBill').val($('#noofsplitBill').val() + $(this).text());
                         }
                      }
                    });
//                  $('#numerodot_px').click(function(){
//                      if (!isNaN($('#noofPax').val())) {
//                         if (parseInt($('#noofPax').val()) == 0) {
//                           $('#noofPax').val($(this).text());
//                         } else {
//                           $('#noofPax').val($('#noofPax').val() + $(this).text().trim());
//                         }
//                      }
//                    });
                  $('.neg').click(function(){
                      if (!isNaN($('#noofsplitBill').val()) && $('#noofsplitBill').val().length > 0) {
                        if (parseInt($('#noofsplitBill').val()) > 0) {
                          $('#noofsplitBill').val(parseInt($('#noofsplitBill').val()) - 1);
                        }
                      }
                  });
                  $('.pos').click(function(){
                      if (!isNaN($('#noofsplitBill').val()) && $('#noofsplitBill').val().length > 0) {
                        $('#noofsplitBill').val(parseInt($('#noofsplitBill').val()) + 1);
                      }
                  });
                  $('#del_sp').click(function(){
                      $('#noofsplitBill').val($('#noofsplitBill').val().substring(0,$('#noofsplitBill').val().length - 1));
                  });
                  $('#clear_sp').click(function(){
                      $('#noofsplitBill').val('');
                  });
                  $('#zero_sp').click(function(){
                    if (!isNaN($('#noofsplitBill').val())) {
                      if (parseInt($('#noofsplitBill').val()) != 0) {
                        $('#noofsplitBill').val($('#noofsplitBill').val() + $(this).text());
                      }
                    }
                  });
                  
                  // for split pay
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#splitpaymenttenderAmt", function(){
                	  $('#n_keypad_sppay').fadeToggle('fast');
                  });
                  
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#done_sppay", function(){
                      $('#n_keypad_sppay').hide('fast');
                      getChangeAmtForSplit($('#splitpaymenttenderAmt').val());
                  });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numero1_sppay", function(){
                    if (!isNaN($('#splitpaymenttenderAmt').val())) {
                       if (parseInt($('#splitpaymenttenderAmt').val()) == 0) {
                         $('#splitpaymenttenderAmt').val($(this).text());
                       } else {
                         $('#splitpaymenttenderAmt').val($('#splitpaymenttenderAmt').val() + $(this).text());
                       }
                    }
                  });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numero2_sppay", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val())) {
                         if (parseInt($('#splitpaymenttenderAmt').val()) == 0) {
                           $('#splitpaymenttenderAmt').val($(this).text());
                         } else {
                           $('#splitpaymenttenderAmt').val($('#splitpaymenttenderAmt').val() + $(this).text());
                         }
                      }
                    });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numero3_sppay", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val())) {
                         if (parseInt($('#splitpaymenttenderAmt').val()) == 0) {
                           $('#splitpaymenttenderAmt').val($(this).text());
                         } else {
                           $('#splitpaymenttenderAmt').val($('#splitpaymenttenderAmt').val() + $(this).text());
                         }
                      }
                    });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numero4_sppay", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val())) {
                         if (parseInt($('#splitpaymenttenderAmt').val()) == 0) {
                           $('#splitpaymenttenderAmt').val($(this).text());
                         } else {
                           $('#splitpaymenttenderAmt').val($('#splitpaymenttenderAmt').val() + $(this).text());
                         }
                      }
                    });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numero5_sppay", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val())) {
                         if (parseInt($('#splitpaymenttenderAmt').val()) == 0) {
                           $('#splitpaymenttenderAmt').val($(this).text());
                         } else {
                           $('#splitpaymenttenderAmt').val($('#splitpaymenttenderAmt').val() + $(this).text());
                         }
                      }
                    });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numero6_sppay", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val())) {
                         if (parseInt($('#splitpaymenttenderAmt').val()) == 0) {
                           $('#splitpaymenttenderAmt').val($(this).text());
                         } else {
                           $('#splitpaymenttenderAmt').val($('#splitpaymenttenderAmt').val() + $(this).text());
                         }
                      }
                    });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numero7_sppay", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val())) {
                         if (parseInt($('#splitpaymenttenderAmt').val()) == 0) {
                           $('#splitpaymenttenderAmt').val($(this).text());
                         } else {
                           $('#splitpaymenttenderAmt').val($('#splitpaymenttenderAmt').val() + $(this).text());
                         }
                      }
                    });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numero8_sppay", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val())) {
                         if (parseInt($('#splitpaymenttenderAmt').val()) == 0) {
                           $('#splitpaymenttenderAmt').val($(this).text());
                         } else {
                           $('#splitpaymenttenderAmt').val($('#splitpaymenttenderAmt').val() + $(this).text());
                         }
                      }
                    });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numero9_sppay", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val())) {
                         if (parseInt($('#splitpaymenttenderAmt').val()) == 0) {
                           $('#splitpaymenttenderAmt').val($(this).text());
                         } else {
                           $('#splitpaymenttenderAmt').val($('#splitpaymenttenderAmt').val() + $(this).text());
                         }
                      }
                    });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numerodot_sppay", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val())) {
                         if (parseInt($('#splitpaymenttenderAmt').val()) == 0) {
                           $('#splitpaymenttenderAmt').val($(this).text());
                         } else {
                           $('#splitpaymenttenderAmt').val($('#splitpaymenttenderAmt').val() + $(this).text().trim());
                         }
                      }
                    });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", ".neg", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val()) && $('#splitpaymenttenderAmt').val().length > 0) {
                        if (parseInt($('#splitpaymenttenderAmt').val()) > 0) {
                          $('#splitpaymenttenderAmt').val(parseInt($('#splitpaymenttenderAmt').val()) - 1);
                        }
                      }
                  });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", ".pos", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val()) && $('#splitpaymenttenderAmt').val().length > 0) {
                        $('#splitpaymenttenderAmt').val(parseInt($('#splitpaymenttenderAmt').val()) + 1);
                      }
                  });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#del_sppay", function(){
                      $('#splitpaymenttenderAmt').val($('#splitpaymenttenderAmt').val().substring(0,$('#splitpaymenttenderAmt').val().length - 1));
                  });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#clear_sppay", function(){
                      $('#splitpaymenttenderAmt').val('');
                  });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#zero_sppay", function(){
                    if (!isNaN($('#splitpaymenttenderAmt').val())) {
                      if (parseInt($('#splitpaymenttenderAmt').val()) != 0) {
                        $('#splitpaymenttenderAmt').val($('#splitpaymenttenderAmt').val() + $(this).text());
                      }
                    }
                  });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numero100_sppay", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val())) {
                         if ($('#splitpaymenttenderAmt').val() == '') {
                           $('#splitpaymenttenderAmt').val(100);
                         } else {
                           $('#splitpaymenttenderAmt').val(parseInt($('#splitpaymenttenderAmt').val()) + 100);
                         }
                      }
                    });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numero50_sppay", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val())) {
                         if ($('#splitpaymenttenderAmt').val() == '') {
                           $('#splitpaymenttenderAmt').val(50);
                         } else {
                           $('#splitpaymenttenderAmt').val(parseInt($('#splitpaymenttenderAmt').val()) + 50);
                         }
                      }
                    });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numero20_sppay", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val())) {
                         if ($('#splitpaymenttenderAmt').val() == '') {
                           $('#splitpaymenttenderAmt').val(20);
                         } else {
                           $('#splitpaymenttenderAmt').val(parseInt($('#splitpaymenttenderAmt').val()) + 20);
                         }
                      }
                    });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numero10_sppay", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val())) {
                         if ($('#splitpaymenttenderAmt').val() == '') {
                           $('#splitpaymenttenderAmt').val(10);
                         } else {
                           $('#splitpaymenttenderAmt').val(parseInt($('#splitpaymenttenderAmt').val()) + 10);
                         }
                      }
                    });
                  $('#cashmodSplitPaymentBodyAmountDetails').on( "click", "#numerorm5_sppay", function(){
                      if (!isNaN($('#splitpaymenttenderAmt').val())) {
                         if ($('#splitpaymenttenderAmt').val() == '') {
                           $('#splitpaymenttenderAmt').val(5);
                         } else {
                           $('#splitpaymenttenderAmt').val(parseInt($('#splitpaymenttenderAmt').val()) + 5);
                         }
                      }
                    });
                  //for manual qty
                  var man;
                  var itid;
                  $('#orderitemContId').on( "click", ".ordermanualQty", function(){
                	  man=$(this);
                	  itid=this.id;
                	  if(softKey=='Y')
                		  {
                		  $('#kepadmanQty').val('');
                    	  $('#manualqtyModal').modal('show');
                    	  $('#n_keypad_man').fadeToggle('fast');
                		  }
                	});
                  $('#manualqtyModal').on( "click", ".done_man", function(){
                      
                      if($('#kepadmanQty').val()!='' /*&& parseInt($('#kepadmanQty').val())!=0*/)
                    	  {
                    	  $('#n_keypad_man').hide('fast');
                          $('#manualqtyModal').modal('hide');
                    	  //man.val($('#kepadmanQty').val());
                          enterManualQuantity($('#kepadmanQty').val(),itid.substring(3,itid.length));
                    	  }
                     });
                  /*$('#manualqtyModal').on( "click", ".numero1_man", function(){
                	 alert('jjjj'+man.val());
                    if (!isNaN(man.val())) {
                       if (parseInt(man.val()) == 0) {
                         man.val($(this).text());
                         alert('jjjjkkkkk');
                       } else {
                         man.val($('.ordermanualQty').val() + $(this).text());
                         alert('jjjjmmmm');
                       }
                    }
                  });*/
                  $('#manualqtyModal').on( "click", ".numero1_man", function(){
                      if (!isNaN($('#kepadmanQty').val())) {
                         if (parseInt($('#kepadmanQty').val()) == 0) {
                           //$('#kepadmanQty').val($(this).text());
                        	 $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         } else {
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         }
                      }
                    });
                  $('#manualqtyModal').on( "click", ".numero2_man", function(){
                      if (!isNaN($('#kepadmanQty').val())) {
                         if (parseInt($('#kepadmanQty').val()) == 0) {
                          // $('#kepadmanQty').val($(this).text());
                        	 $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         } else {
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         }
                      }
                    });
                  $('#manualqtyModal').on( "click", ".numero3_man", function(){
                      if (!isNaN($('#kepadmanQty').val())) {
                         if (parseInt($('#kepadmanQty').val()) == 0) {
                          // $('#kepadmanQty').val($(this).text());
                        	 $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         } else {
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         }
                      }
                    });
                  $('#manualqtyModal').on( "click", ".numero4_man", function(){
                      if (!isNaN($('#kepadmanQty').val())) {
                         if (parseInt($('#kepadmanQty').val()) == 0) {
                          // $('#kepadmanQty').val($(this).text());
                        	 $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         } else {
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         }
                      }
                    });
                  $('#manualqtyModal').on( "click", ".numero5_man", function(){
                      if (!isNaN($('#kepadmanQty').val())) {
                         if (parseInt($('#kepadmanQty').val()) == 0) {
                           //$('#kepadmanQty').val($(this).text());
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         } else {
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         }
                      }
                    });
                  $('#manualqtyModal').on( "click", ".numero6_man", function(){
                      if (!isNaN($('#kepadmanQty').val())) {
                         if (parseInt($('#kepadmanQty').val()) == 0) {
                           //$('#kepadmanQty').val($(this).text());
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         } else {
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         }
                      }
                    });
                  $('#manualqtyModal').on( "click", ".numero7_man", function(){
                      if (!isNaN($('#kepadmanQty').val())) {
                         if (parseInt($('#kepadmanQty').val()) == 0) {
                           //$('#kepadmanQty').val($(this).text());
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         } else {
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         }
                      }
                    });
                  $('#manualqtyModal').on( "click", ".numero8_man", function(){
                      if (!isNaN($('#kepadmanQty').val())) {
                         if (parseInt($('#kepadmanQty').val()) == 0) {
                           //$('#kepadmanQty').val($(this).text());
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         } else {
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         }
                      }
                    });
                  $('#manualqtyModal').on( "click", ".numero9_man", function(){
                      if (!isNaN($('#kepadmanQty').val())) {
                         if (parseInt($('#kepadmanQty').val()) == 0) {
                           //$('#kepadmanQty').val($(this).text());
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         } else {
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                         }
                      }
                    });
                  $('#manualqtyModal').on( "click", ".numerodot_man", function(){
                      if (!isNaN($('#kepadmanQty').val())) {
                         if (parseInt($('#kepadmanQty').val()) == 0) {
                          // $('#kepadmanQty').val($(this).text());
                        	 $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text().trim());
                        	 
                         } else {
                           $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text().trim());
                         }
                      }
                    });
                  
                  
                  $('#manualqtyModal').on( "click", ".del_man", function(){
                      $('#kepadmanQty').val($('#kepadmanQty').val().substring(0,$('#kepadmanQty').val().length - 1));
                  });
                  $('#manualqtyModal').on( "click", ".clear_man", function(){
                      $('#kepadmanQty').val('');
                  });
                  $('#manualqtyModal').on( "click", ".zero_man", function(){
                    if (!isNaN($('#kepadmanQty').val())) {
                      if (parseInt($('#kepadmanQty').val()) != 0) {
                        $('#kepadmanQty').val($('#kepadmanQty').val() + $(this).text());
                      }
                    }
                  });
                 
      });
