class Api::V0::Turing::TuringController < ApplicationController

  def docs
    render plain: {data: docs_data, status: 200, success: true}.to_json, status: 200, content_type: 'application/json'
  end

  def members
    if params[:email] == 'steven@trel.co' &&  params[:password] == 'password'
      @member =  member_one_data
    elsif params[:email] == 'carol@trel.co' && params[:password] == 'password1'
      @member = member_two_data
    else
      @member = nil
    end

    if @member.present?
      render json: {
        data: @member,
        status: 200,
        success: true
      }
    else
      render json: {
        data: {
          error: 'Member does not exist! 🔐',
          status: 422
        }
      }
    end
  end

  def properties
    if params[:HTTP_AUTH_TOKEN].nil?
      render json: {
        data: {
          message: 'Did you forget to pass an AUTH_TOKEN? 🚯',
          status: 500,
        }
      }
    elsif params[:HTTP_AUTH_TOKEN] != ('this_is_a_very_simple_auth_token_string' || 'this_is_an_auth_token_string_for_carol')
      render json: {
        data: {
          message: 'You passed an AUTH_TOKEN, but it does not match the user 🤔',
          status: 500
        }
      }
    else params[:HTTP_AUTH_TOKEN] && params[:address]
      property_data
    end
  end

  def update_listing_consultation
    #requires user email, auth_token.
    #other fields are up to turing...what do they think is required??
    if (params[:email].present? && params[:HTTP_AUTH_TOKEN].present? && params[:address].present?)
      render json: {
        listing_consultation: {
          created_at: Time.now,
          member: {
            email: params[:email],
            name: params[:name]
          },
          address: {
            code: params[:address],
          },
          consultation: {
            about_this_home: params[:about_this_home],
            recommended_list_price: params[:list_price],
            client_enthusiasm: params[:client_enthusiasm],
            commission: params[:commission],
            about_the_seller: params[:about_the_seller],
            credit_card: "****_****_****_****",
            exp_date: params[:exp_date]
          }
        }
      }
    else
      render json: {
        data: {
          error: 'you forgot to send a member... || you forgot to send an AUTH_TOKEN',
          status: 404
        }
      }
    end
  end

  private


  def property_data
    if params[:address] == '1860_south_marion_street-Denver-CO-80210'
      denver_address
    elsif params[:address] == '910_portland_place-Boulder-CO-80304'
      boulder_address
    else
      render json: {
        data: {
          message: 'Property not found! 🏡🚨',
          status: 404
        }
      }
    end
  end

  def denver_address
    render json: {
      "success": true,
      "result": {
        client: {
          client_info: {
            name: 'Tyler Long',
            email: 'tyler+12@trelora.com',
            phone: '3033333333'
          },
          opted_in: {
            result: true
          },
          found_us: 'Google Search',
          enthusiasm: 'Interested in Moving Forward',
          timing: 'Less than 2 Months',
          adopter_type: 'Early Adopter',
          stage: 'Just getting interested in prepping home for sale. Wants to sell and use $$ to buy with us as well.'
        },
        pricing_estimates: {
          zillow: {
            zestimate: 704000,
            low: 696000,
            high: 754000
          },
          home_junction: {
            low: 578000,
            high: 679000,
            regional_avg: 689000
          },
        },
        listing: {
          coordinates: {
            latitude: "39.683019",
            longitude: "-104.971964"
          },
          id: "1860_south_marion_street-Denver-CO-80210",
          mls: "N/A",
          home_updates: {
            exterior: 'New Roof in 07/15',
            interior: 'Basement Updated and Finished 8/2016'
          },
          address: {
            address1: "1860 South Marion Street",
            address2: "",
            city: "Denver",
            state: "CO",
            zip: "80210"
          },
          baths: 3,
          beds: 4
        }
      }
    }
  end

  def boulder_address
    render json: {
      "success": true,
      "result": {
        client: {
          client_info: {
            name: 'Eric Spery',
            email: 'eric+12@trelora.com',
            phone: '3033330000'
          },
          opted_in: {
            result: true
          },
          found_us: 'Referral',
          enthusiasm: 'Interested in Moving Forward',
          timing: 'Less than 1 Month',
          adopter_type: 'Slow to adopt',
          stage: 'Does not want to sell right away, but needs to be move to be closer to his aging parents.'
        },
        pricing_estimates: {
          zillow: {
            zestimate: 10005000,
            low: 999000,
            high: nil
          },
          home_junction: {
            low: 888000,
            high: 1600000,
            regional_avg: 1200000
          },
        },
        listing: {
          coordinates: {
            latitude: "40.023055",
            longitude: "-105.285121"
          },
          id: "910_portland_place-Boulder-CO-80304",
          mls: "N/A",
          home_updates: {
            exterior: 'New Dec in 07/15 and updated landscaping 8/18',
            interior: 'Remodeled kitchen last year'
          },
          address: {
            address1: "910 Portland Place",
            address2: "",
            city: "Boulder",
            state: "CO",
            zip: "80304"
          },
          baths: 2,
          beds: 3,
          sqft: 1800
        }
      }
    }
  end


  def member_one_data
    {
      user: {
        name: 'steven j',
        email: 'steven@trel.co',
        created_at: Time.now - 1.day,
        updated_at: Time.now,
        HTTP_AUTH_TOKEN: 'this_is_a_very_simple_auth_token_string'
      },
      available_address: {
        message: 'These are mock addresses available. You will need to use one of these ids in the next step',
        addresses: {
          one: {
            id: '1860_south_marion_street-Denver-CO-80210'
          },
          two: {
            id: '910-portland_place-Boulder-CO-80304'
          }
        }
      }
    }
  end

  def member_two_data
    {
      user: {
        name: 'carol s',
        email: 'carol@trel.co',
        created_at: Time.now - 1.day,
        updated_at: Time.now,
        HTTP_AUTH_TOKEN: 'this_is_an_auth_token_string_for_carol',
        message: 'THIS IS A MOCK USER'
      },
      available_address: {
        message: 'These are mock addresses available. You will need to use one of these ids in the next step',
        addresses: {
          one: {
            id: '1860_south_marion_street-Denver-CO-80210'
          },
          two: {
            id: '910-portland_place-Boulder-CO-80304'
          }
        }
      }
    }
  end

  def docs_data
    {
      routes: {
        api: {
          v0: {
            docs: {
              name: "api/v0/turing/docs",
              action: 'GET',
              required_params: "none",
              description: "Shows you routes, as JSON! 📊"
            },
            members: {
              name: "api/v0/turing/members",
              action: 'POST',
              required_params: 'email:STRING, password:STRING',
              description: "Validates a member, if exists. JSON"
            },
            properties: {
              name: "api/v0/turing/properties",
              action: 'POST',
              required_params: "address:STRING, HTTP_AUTH_TOKEN:STRING",
              description: "property details. JSON"
            },
            update_listing_consultation: {
              name: 'api/v0/turing/update_listing_consultation',
              action: 'POST',
              required_params: 'email:STRING, HTTP_AUTH_TOKEN:STRING, address:STRING (this is the `id` you used to get data on the home in /properties',
              optional_params: {
                "about_this_home": 'STRING' ,
                "recommended_list_price": 'STRING',
                "client_enthusiasm": 'STRING',
                "commission": 'STRING',
                "about_the_seller": 'STRING',
                "credit_card": "****_****_****_****",
                "exp_date": 'STRING'
              }
            }
          }
        }
      }
    }
  end
end
