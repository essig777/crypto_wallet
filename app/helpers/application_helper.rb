module ApplicationHelper

  def locale
    if  I18n.locale == :en
      "Estados Unidos"
    else
      "Português(BR)"
    end
    end
  def nome_aplicacao
     "CRYPTO WALLET APP"
  end

  def ambiente_rails
    if Rails.env.development?
      "Desenvolvimento"
    elsif Rails.env.production?
      "Produção"
    else 
      "Teste"
    end
  end
end
