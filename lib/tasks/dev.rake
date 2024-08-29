# namespace :dev do
#   desc "Configura o ambiente de desenvolvimento"
#   task setup: :environment do
#     if Rails.env.development? 
#       spinner = TTY::Spinner.new("[:spinner] Executando tarefas ...", format: :arc)
#       spinner.auto_spin
#       %x(rails db:drop db:create db:migrate db:seed)
      
#       spinner.stop("\nConcluído!")
#     else
#       puts "Você não está em ambiente de desenvolvimento"
#   end
# end


namespace :dev do

  def show_spinner(msg_start, msg_end = "Concluído")
    spinner = TTY::Spinner.new("[ :spinner ] #{msg_start}", format: :arc)
    spinner.auto_spin
    yield
    spinner.success("#{msg_end}")
end

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    
      if Rails.env.development?
        show_spinner("Apagando BD...") {%x(rails db:drop)}
        show_spinner("Criando BD...") {%x(rails db:create)} 
        show_spinner("Migrando BD...") {%x(rails db:migrate)}              
        %x(rails dev:add_mining_types)
        %x(rails dev:add_coins)
      else
      puts "Você não está em ambiente de desenvolvimento"
  end
end


    desc "Cadastra as moedas"
      task add_coins: :environment do
        show_spinner("Cadastrando moedas...") do

    coins = [
        {
        description: "Bitcoin",
        acronym: "BTC",
        url_image: "https://cdn.pixabay.com/photo/2018/08/30/12/24/bitcoin-3642042_960_720.png",
        mining_type: MiningType.where(acronym: 'PoW').first
        },

        {
        description: "Ethereum",
        acronym: "ETH",
        url_image: "https://www.svgrepo.com/show/341796/ethereum.svg",
        mining_type: MiningType.all.sample
        },

        {
        description: "Dash",
        acronym: "DASH",
        url_image: "https://cryptologos.cc/logos/dash-dash-logo.png",
        mining_type: MiningType.all.sample
        },

        {
        description: "Iota",
        acronym: "IOT",
        url_image: "https://w7.pngwing.com/pngs/486/784/png-transparent-iota-cryptocurrency-wallet-cryptocurrency-wallet-bitfinex-coin-design-emblem-label-exchange.png",
        mining_type: MiningType.all.sample  
        },
        {
        description: "ZCash",
        acronym: "ZEC",
        url_image: "https://cryptologos.cc/logos/zcash-zec-logo.png",
        mining_type: MiningType.all.sample
        }
    ]

    coins.each do |coin|
    Coin.find_or_create_by!(coin)
    end
    end
  end

  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando os tipos de mineração...") do
    mining_types = [
      {description:"Proof of Work", acronym: "PoW"},
      {description: "Proof of Stake", acronym: "PoS"},
      {description: "Proof of Capacity", acronym: "PoC"}
    ]

    mining_types.each do |mining_type|
      MiningType.find_or_create_by!(mining_type)
      end
      end
  end
end

