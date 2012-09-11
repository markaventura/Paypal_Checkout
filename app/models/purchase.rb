require "rubygems"
require "active_merchant"

ActiveMerchant::Billing::Base.mode = :test

gateway = ActiveMerchant::Billing::PaypalGateway.new(
	:login => "markav_1346897840_biz_api1.gmail.com",
    :password => "1346897888",
    :signature => "A7rjwRXU9YZV2pvUrkKzBmVatsP1AkSAK9dZHdbKP9dEkDQRD1.DcPsP"
)

credit_card = ActiveMerchant::Billing::CreditCard.new(
	:type				=> "visa",
	:number				=> "4024007148673576",
	:verification_value	=> "123",
	:month				=> 1,
	:year				=> Time.now.year+1,
	:first_name			=> "Ryan",
	:last_name			=> "Bates"
)

if credit_card.valid?
	response = gateway.purchase(1000, credit_card, :ip => "127.0.0.1")
	if response.success?
		puts "Purchase Success"
	else
		puts "Nuhhh.. #{response.message}"
	end
else
	puts "Error: credit card is not valid. #{credit_card.errors.full_messages.join('. ')}"
end