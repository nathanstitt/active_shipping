require 'test_helper'

class UPSShippingTest < Test::Unit::TestCase

    def setup
        @packages  = TestFixtures.packages
        @locations = TestFixtures.locations
        UPS.include_ship_support!
        @carrier   = UPS.new(fixtures(:ups))

    end

  def test_ship_package

      shipper = Shipper.new(
                            :shipper_number=>fixtures(:ups)[:account],
                            :name => "AllMed",
                            :country => 'US',
                            :city => 'Jefferson City',
                            :state => 'MO',
                            :address1 => '4715 Scruggs Station Rd',
                            :address2 => '',
                            :address_type=>'commercial',
                            :zip => '65109')
      packages = [@packages[:just_ounces], @packages[:chocolate_stuff]]
      packages.first.reference_numbers << ReferenceNumber.new('O1','A Short String')
      packages.first.reference_numbers << ReferenceNumber.new('O2','A Bit Longer')
      shipment = Shipment.new(
                              :shipper => shipper,
                              :payer => shipper,
                              :destination => @locations[:new_york_with_name],
                              :packages => packages,
                              :printer => Printer.new({   :label_format=>'EPL',
                                                          :width=>8, :height=>4
                                                      }),
                              :number => '3233',
                              :service => '03'
                              )


      @carrier.ship( shipment, {
                                    :test=>true
                                } )


      # usefull for debugging
      # unless shipment.labels.empty?
      #     File.open('/tmp/label.bin','w') do | lp |
      #         lp.write shipment.labels.first.data
      #     end
      # end

      # shipment.log.each_with_index do | log,index |
      #     File.open( "/tmp/ups-#{index}.xml",'w') do | f |
      #         xml = REXML::Document.new( log )
      #         xml.write( f, 2 )
      #     end
      # end

      assert_equal 2, shipment.labels.length

      assert shipment.labels.first.data =~ /TRACKING \#: 1Z/

  end



end
