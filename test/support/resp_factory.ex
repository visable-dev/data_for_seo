defmodule RespFactory do
  def task_post_single_response do
    """
    {
      "version": "0.1.20200129",
      "status_code": 20000,
      "status_message": "Ok.",
      "time": "0.0818 sec.",
      "cost": 0.0045,
      "tasks_count": 1,
      "tasks_error": 0,
      "tasks": [
        {
          "id": "01291721-1535-0066-0000-8f0635c0dc89",
          "status_code": 20100,
          "status_message": "Task Created.",
          "time": "0.0038 sec.",
          "cost": 0.0015,
          "result_count": 0,
          "path": [
            "v3",
            "serp",
            "google",
            "organic",
            "task_post"
          ],
          "data": {
            "api": "serp",
            "function": "task_post",
            "se": "google",
            "se_type": "organic",
            "language_code": "en",
            "location_code": 2840,
            "keyword": "Schrauben",
            "device": "desktop",
            "os": "windows"
          },
          "result": null
        }
      ]
    }
    """
  end

  def task_post_list_response do
    """
    {
      "version": "0.1.20200129",
      "status_code": 20000,
      "status_message": "Ok.",
      "time": "0.0818 sec.",
      "cost": 0.0045,
      "tasks_count": 2,
      "tasks_error": 0,
      "tasks": [
        {
          "id": "01291721-1535-0066-0000-8f0635c0dc89",
          "status_code": 20100,
          "status_message": "Task Created.",
          "time": "0.0038 sec.",
          "cost": 0.0015,
          "result_count": 0,
          "path": [
            "v3",
            "serp",
            "google",
            "organic",
            "task_post"
          ],
          "data": {
            "api": "serp",
            "function": "task_post",
            "se": "google",
            "se_type": "organic",
            "language_code": "en",
            "location_code": 2840,
            "keyword": "Schrauben",
            "device": "desktop",
            "os": "windows"
          },
          "result": null
        },
        {
          "id": "01291721-1535-0066-0000-2e7a8bf7302c",
          "status_code": 20100,
          "status_message": "Task Created.",
          "time": "0.0050 sec.",
          "cost": 0.0015,
          "result_count": 0,
          "path": [
            "v3",
            "serp",
            "google",
            "organic",
            "task_post"
          ],
          "data": {
            "api": "serp",
            "function": "task_post",
            "se": "google",
            "se_type": "organic",
            "language_name": "English",
            "location_name": "United States",
            "keyword": "Blumen",
            "priority":2,
            "pingback_url": "https://your-server.com/pingscript?id=$id&tag=$tag",
            "tag": "some_string_123",
            "device": "desktop",
            "os": "windows"
          },
          "result": null
        }
      ]
    }
    """
  end

  def tasks_ready_response do
    """
    {
      "version": "0.1.20200129",
      "status_code": 20000,
      "status_message": "Ok.",
      "time": "0.2270 sec.",
      "cost": 0,
      "tasks_count": 1,
      "tasks_error": 0,
      "tasks": [
        {
          "id": "11151406-0696-0087-0000-e781cb0144a1",
          "status_code": 20000,
          "status_message": "Ok.",
          "time": "0.0388 sec.",
          "cost": 0,
          "result_count": 2,
          "path": [
            "v3",
            "serp",
            "google",
            "organic",
            "tasks_ready"
          ],
          "data": {
            "api": "serp",
            "function": "tasks_ready",
            "se": "google",
            "se_type": "organic"
          },
          "result": [
            {
              "id": "11081554-0696-0066-0000-27e68ec15871",
              "se": "google",
              "se_type": "organic",
              "date_posted": "2019-11-08 13:54:43 +00:00",
              "endpoint_regular": "/v3/serp/google/organic/task_get/regular/11081554-0696-0066-0000-27e68ec15871",
              "endpoint_advanced": "/v3/serp/google/organic/task_get/advanced/11081554-0696-0066-0000-27e68ec15871",
              "endpoint_html": "/v3/serp/google/organic/task_get/html/11081554-0696-0066-0000-27e68ec15871"
            },
            {
              "id": "11151406-0696-0066-0000-c4ece317cdb2",
              "se": "google",
              "se_type": "organic",
              "date_posted": "2019-11-15 12:06:09 +00:00",
              "endpoint_regular": "/v3/serp/google/organic/task_get/regular/11151406-0696-0066-0000-c4ece317cdb2",
              "endpoint_advanced": "/v3/serp/google/organic/task_get/advanced/11081554-0696-0066-0000-27e68ec15871",
              "endpoint_html": "/v3/serp/google/organic/task_get/html/11151406-0696-0066-0000-c4ece317cdb2"
            }
          ]
        }
      ]
    }
    """
  end

  def task_result_response do
    """
    {
      "version": "0.1.20200129",
      "status_code": 20000,
      "status_message": "Ok.",
      "time": "0.3059 sec.",
      "cost": 0,
      "tasks_count": 1,
      "tasks_error": 0,
      "tasks": [
        {
          "id": "11151456-0696-0066-0000-002a5915da37",
          "status_code": 20000,
          "status_message": "Ok.",
          "time": "0.0952 sec.",
          "cost": 0,
          "result_count": 1,
          "path": [
            "v3",
            "serp",
            "google",
            "organic",
            "task_get",
            "regular",
            "11151456-0696-0066-0000-002a5915da37"
          ],
          "data": {
            "api": "serp",
            "function": "task_get",
            "se": "google",
            "se_type": "organic",
            "language_name": "English",
            "location_name": "United States",
            "keyword": "flight ticket new york san francisco",
            "priority": "2",
            "tag": "tag2",
            "device": "desktop",
            "os": "windows"
          },
          "result": [
            {
              "keyword": "flight ticket new york san francisco",
              "type": "organic",
              "se_domain": "google.com",
              "location_code": 2840,
              "language_code": "en",
              "check_url": "https://www.google.com/search?q=flight%20ticket%20new%20york%20san%20francisco&num=100&hl=en&gl=US&gws_rd=cr&ie=UTF-8&oe=UTF-8&uule=w+CAIQIFISCQs2MuSEtepUEUK33kOSuTsc",
              "datetime": "2019-11-15 12:57:46 +00:00",
              "spell": null,
              "item_types": [
                "organic",
                "paid"
              ],
              "se_results_count": 85600000,
              "items_count": 96,
              "items": [
                {
                  "type": "paid",
                  "rank_group": 1,
                  "rank_absolute": 1,
                  "domain": "www.bookingbuddy.com",
                  "title": "Flights To Lwo | Unbelievably Cheap Flights | BookingBuddy.com‎",
                  "description": "Compare Airlines & Sites. Cheap Flights on BookingBuddy, a TripAdvisor Company",
                  "url": "https://www.bookingbuddy.com/en/hero/",
                  "breadcrumb": "www.bookingbuddy.com/Flights"
                },
                {
                  "type": "paid",
                  "rank_group": 2,
                  "rank_absolute": 2,
                  "domain": "www.trip.com",
                  "title": "Cheap Flight Tickets | Search & Find Deals on Flights | trip.com‎",
                  "description": "Wide Selection of Cheap Flights Online. Explore & Save with Trip.com! Fast, Easy & Secure...",
                  "url": "https://www.trip.com/flights/index?utm_campaign=GG_SE_All_en_Flight_Generic_NA_Phrase",
                  "breadcrumb": "www.trip.com/"
                },
                {
                  "type": "paid",
                  "rank_group": 3,
                  "rank_absolute": 4,
                  "domain": "www.kayak.com",
                  "title": "Find the Cheapest Flights | Search, Compare & Save Today‎",
                  "description": "Cheap Flights, Airline Tickets and Flight Deals. Compare 100s of Airlines Worldwide. Search...",
                  "url": "https://www.kayak.com/horizon/sem/flights/general",
                  "breadcrumb": "www.kayak.com/flights"
                },
                {
                  "type": "organic",
                  "rank_group": 1,
                  "rank_absolute": 5,
                  "domain": "www.kayak.com",
                  "title": "Cheap Flights from New York to San Francisco from $182 ...",
                  "description": "Fly from New York to San Francisco on Frontier from $182, United Airlines from ... the cheapest round-trip tickets were found on Frontier ($182), United Airlines ...",
                  "url": "https://www.kayak.com/flight-routes/New-York-NYC/San-Francisco-SFO",
                  "breadcrumb": "https://www.kayak.com › Flights › North America › United States › California"
                },
                {
                  "type": "organic",
                  "rank_group": 2,
                  "rank_absolute": 6,
                  "domain": "www.skyscanner.com",
                  "title": "Cheap flights from New York to San Francisco SFO from $123 ...",
                  "description": "Flight information New York to San Francisco International .... tool will help you find the cheapest tickets from New York in San Francisco in just a few clicks.",
                  "url": "https://www.skyscanner.com/routes/nyca/sfo/new-york-to-san-francisco-international.html",
                  "breadcrumb": "https://www.skyscanner.com › United States › New York"
                },
                {
                  "type": "organic",
                  "rank_group": 3,
                  "rank_absolute": 7,
                  "domain": "www.expedia.com",
                  "title": "JFK to SFO: Flights from New York to San Francisco for 2019 ...",
                  "description": "Book your New York (JFK) to San Francisco (SFO) flight with our Best Price ... How much is a plane ticket to San Francisco (SFO) from New York (JFK)?.",
                  "url": "https://www.expedia.com/lp/flights/jfk/sfo/new-york-to-san-francisco",
                  "breadcrumb": "https://www.expedia.com › flights › jfk › sfo › new-york-to-san-francisco"
                },
                {
                  "type": "organic",
                  "rank_group": 94,
                  "rank_absolute": 97,
                  "domain": "www.ethiopianairlines.com",
                  "title": "Ethiopian Airlines | Book your next flight online and Fly Ethiopian",
                  "description": "Fly to your Favorite International Destination with Ethiopian Airlines. Book your Flights Online for Best Offers/Discounts and Enjoy African Flavored Hospitality.",
                  "url": "https://www.ethiopianairlines.com/",
                  "breadcrumb": "https://www.ethiopianairlines.com"
                },
                {
                  "type": "organic",
                  "rank_group": 95,
                  "rank_absolute": 98,
                  "domain": "www.vietnamairlines.com",
                  "title": "Vietnam Airlines | Reach Further | Official website",
                  "description": "Great value fares with Vietnam Airlines. Book today and save! Skytrax – 4 Star airline. Official website. Earn frequent flyer miles with Lotusmiles.",
                  "url": "https://www.vietnamairlines.com/",
                  "breadcrumb": "https://www.vietnamairlines.com"
                },
                {
                  "type": "organic",
                  "rank_group": 96,
                  "rank_absolute": 99,
                  "domain": "books.google.com",
                  "title": "Code of Federal Regulations: 1985-1999",
                  "description": "A purchases in New York a round-trip ticket for transportation by air from New York to ... B purchases a ticket in San Francisco for Combination rail and water ...",
                  "url": "https://books.google.com/books?id=av3umFsqbAEC&pg=PA305&lpg=PA305&dq=flight+ticket+new+york+san+francisco&source=bl&ots=fJJY5RUS9l&sig=ACfU3U16ejUqNf23jHD32QNCxDCa05Vn9g&hl=en&ppis=_e&sa=X&ved=2ahUKEwjs_4OnouzlAhXJ4zgGHeBcD3oQ6AEwdXoECHEQAQ",
                  "breadcrumb": "https://books.google.com › books"
                }
              ]
            }
          ]
        }
      ]
    }
    """
  end
end
