(function($) {
  'use strict';

  $(document).ready(function() {
    //Submenu Dropdown Toggle
    if ($('.main-header li.dropdown ul').length) {
      $('.main-header li.dropdown').append(
        '<div class="dropdown-btn"><span class="fa fa-angle-down"></span></div>'
      );

      //Dropdown Button
      $('.main-header li.dropdown .dropdown-btn').on('click', function() {
        $(this)
          .prev('ul')
          .slideToggle(500);
      });

      //Dropdown Menu / Fullscreen Nav
      $('.fullscreen-menu .navigation li.dropdown > a').on('click', function() {
        $(this)
          .next('ul')
          .slideToggle(500);
      });

      //Disable dropdown parent link
      $('.navigation li.dropdown > a').on('click', function(e) {
        e.preventDefault();
      });

      //Disable dropdown parent link
      $(
        '.main-header .navigation li.dropdown > a,.hidden-bar .side-menu li.dropdown > a'
      ).on('click', function(e) {
        e.preventDefault();
      });
    }

    // Preloader Js
    $(window).load(function() {
      $('.preloader').fadeOut(1000); // set duration in brackets
    });

    // Scroll to top
    $.scrollUp({
      scrollText: '<i class="fa fa-angle-up"></i>',
      easingType: 'linear',
      scrollSpeed: 900,
      animation: 'fade'
    });

    //Counter-JS
    $('.count').counterUp({
      delay: 10,
      time: 2000
    });

    //Video Pop up
    $('.video-popup').magnificPopup({
      type: 'iframe'
    });

    //Image Pop up
    $('.portfolio-gallery').each(function() {
      $(this)
        .find('.popup-gallery')
        .magnificPopup({
          type: 'image',
          gallery: {
            enabled: true
          }
        });
    });

    //testimonials Slider Active
    $('.testimonials').owlCarousel({
      loop: true,
      responsiveClass: true,
      nav: false,
      autoplay: false,
      dots: true,
      autoplayTimeout: 4000,
      smartSpeed: 1000,
      margin: 30,
      responsive: {
        0: {
          items: 1
        },
        768: {
          items: 1
        },
        1170: {
          items: 2
        }
      }
    });

    //Service testimonials Slider Active
    $('.service-testimonials').owlCarousel({
      loop: true,
      responsiveClass: true,
      nav: false,
      autoplay: true,
      dots: true,
      autoplayTimeout: 4000,
      smartSpeed: 1000,
      margin: 0,
      responsive: {
        0: {
          items: 1
        },
        768: {
          items: 1
        },
        1170: {
          items: 1
        }
      }
    });

    //Blog Slider
    $('.blog-slide').owlCarousel({
      loop: true,
      responsiveClass: true,
      nav: true,
      navText: [
        '<i class="fa fa-angle-left"></i>',
        '<i class="fa fa-angle-right"></i>'
      ],
      autoplay: true,
      dots: false,
      autoplayTimeout: 4000,
      smartSpeed: 1000,
      margin: 0,
      responsive: {
        0: {
          items: 1
        },
        768: {
          items: 1
        },
        1170: {
          items: 1
        }
      }
    });

    /* ---------------------------------------------
         portfolio filtering
         --------------------------------------------- */

    var $portfolio = $('.portfolio');
    if ($.fn.imagesLoaded && $portfolio.length > 0) {
      imagesLoaded($portfolio, function() {
        $portfolio.isotope({
          itemSelector: '.portfolio-item',
          filter: '*'
        });
        $(window).trigger('resize');
      });
    }

    $('.portfolio-filter').on('click', 'a', function(e) {
      e.preventDefault();
      $(this)
        .parent()
        .addClass('active')
        .siblings()
        .removeClass('active');
      var filterValue = $(this).attr('data-filter');
      $portfolio.isotope({ filter: filterValue });
    });

    /*---------------------------------------------
         Portfolio popup
         ---------------------------------------------*/

    $('.portfolio-gallery').each(function() {
      $(this)
        .find('.popup-gallery')
        .magnificPopup({
          type: 'image',
          gallery: {
            enabled: true
          }
        });
    });

    $('.video-popup').magnificPopup({
      type: 'iframe'
    });
    $('#example_wrapper').addClass('dt-bootstrap4');
    $('#example').DataTable();
    $('.datepicker').datepicker({
      multidate: true,
      autoclose: true,
      startDate: new Date()
    });
    $('#example_filter > label')
      .text()
      .replace('Search:', '');
    $('.dataTables_filter > label > input')
      .addClass('form-control form-control-sm')
      .attr('placeholder', 'Search...');
    $('.dataTables_length > label > select')
      .addClass('custom-select custom-select-sm form-control form-control-sm')
      .width('30');
  });

  //Faq area Accordion
  $('.accordion > li:eq(0) a')
    .addClass('active')
    .next()
    .slideDown();

  $('.accordion a').on('click', function(j) {
    var dropDown = $(this)
      .closest('li')
      .find('p');

    $(this)
      .closest('.accordion')
      .find('p')
      .not(dropDown)
      .slideUp();

    if ($(this).hasClass('active')) {
      $(this).removeClass('active');
    } else {
      $(this)
        .closest('.accordion')
        .find('a.active')
        .removeClass('active');
      $(this).addClass('active');
    }

    dropDown.stop(false, true).slideToggle();

    j.preventDefault();
  });

  //Google Map

  function basicmap() {
    // Basic options for a simple Google Map
    // For more options see: https://developers.google.com/maps/documentation/javascript/reference#MapOptions
    var mapOptions = {
      // How zoomed in you want the map to start at (always required)
      zoom: 15,
      scrollwheel: false,
      // The latitude and longitude to center the map (always required)
      center: new google.maps.LatLng(23.8748, 90.3858), // New York
      // This is where you would paste any style found on Snazzy Maps.
      styles: [
        {
          featureType: 'administrative',
          elementType: 'labels.text.fill',
          stylers: [
            {
              color: '#444444'
            }
          ]
        },
        {
          featureType: 'landscape',
          elementType: 'all',
          stylers: [
            {
              color: '#f2f2f2'
            }
          ]
        },
        {
          featureType: 'poi',
          elementType: 'all',
          stylers: [
            {
              visibility: 'off'
            }
          ]
        },
        {
          featureType: 'road',
          elementType: 'all',
          stylers: [
            {
              saturation: -100
            },
            {
              lightness: 45
            }
          ]
        },
        {
          featureType: 'road.highway',
          elementType: 'all',
          stylers: [
            {
              visibility: 'simplified'
            }
          ]
        },
        {
          featureType: 'road.arterial',
          elementType: 'labels.icon',
          stylers: [
            {
              visibility: 'off'
            }
          ]
        },
        {
          featureType: 'transit',
          elementType: 'all',
          stylers: [
            {
              visibility: 'off'
            }
          ]
        },
        {
          featureType: 'water',
          elementType: 'all',
          stylers: [
            {
              color: '#46bcec'
            },
            {
              visibility: 'on'
            }
          ]
        }
      ]
    };
    // Get the HTML DOM element that will contain your map
    // We are using a div with id="map" seen below in the <body>
    var mapElement = document.getElementById('map');

    // Create the Google Map using our element and options defined above
    var map = new google.maps.Map(mapElement, mapOptions);

    // Let's also add a marker while we're at it
    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(23.8748, 90.3858),
      map: map,
      title: 'Cryptox'
    });
  }
  if ($('#map').length != 0) {
    google.maps.event.addDomListener(window, 'load', basicmap);
  }

  //Wow js active
  //new WOW().init();
})(jQuery);
