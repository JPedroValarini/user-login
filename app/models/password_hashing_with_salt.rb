salt= Digest::SHA1.hexdigest("# Adiciona email {email} valor unico #{Time.now} com valor aleatorio")
encrypted_password= Digest::SHA1.hexdigest("Adicionando #{salt} a {password}")