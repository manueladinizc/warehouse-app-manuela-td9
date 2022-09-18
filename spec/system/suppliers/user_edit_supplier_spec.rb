require 'rails_helper'

describe 'Usuário edita um fornecedor' do
    it 'a partir da página de detalhes' do
        #Arran
        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'434343', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
        
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'ACME'
        click_on 'Editar'
        #Assert
        expect(page).to have_field('Nome Fantasia', with: 'ACME')
        expect(page).to have_field('Razão Social', with: 'ACME LTDA')
        expect(page).to have_field('CNPJ', with: '434343')
        expect(page).to have_field('Endereço', with: 'Av das Palmas, 100')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Estado', with: 'SP')
        expect(page).to have_field('E-mail', with: 'contato@acme.com')
        
    end

    it 'com sucesso' do
        #Arrange
        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'434343', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
        
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'ACME'
        click_on 'Editar'
        fill_in 'CNPJ', with: '020202'
        fill_in 'Endereço', with: 'Av das Palmas, 111'
        fill_in 'E-mail', with: 'contatoCorp@acme.com'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content 'Fornecedor atualizado com sucesso'
        expect(page).to have_content 'Documento: 020202'
        expect(page).to have_content 'Endereço: Av das Palmas, 111'
        expect(page).to have_content 'E-mail: contatoCorp@acme.com'
    end

    it 'e mantém os campos obrigatórios' do
        #Arran
        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'434343', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
        
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'ACME'
        click_on 'Editar'
        fill_in 'CNPJ', with: ''
        fill_in 'Endereço', with: ''
        fill_in 'E-mail', with: ''
        click_on 'Enviar'
        #Assert
        expect(page).to have_content 'Não foi possível atualizar o fornecedor'
              
    end
end