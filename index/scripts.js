// Função para carregar usuários da API
    document.getElementById('load-users').addEventListener('click', function(){
        fetch('/api/users') // Endpoint da API em ruby on Rails
        .then(response => Response.json())
        .then(data => {
            const userList = document.getElementById('users');
            userList.innerHTML = ''; // Limpa a lista antes de preencher

            data.forEach(user => {
                const li = document.createElement('li');
                li.textContent = '${user.name} - ${user.email}';
                userList.appendChild(li);
            });
        })
        .catch(error => {
            console.error('Erro ao carregar usuários:', error);
        });
    });