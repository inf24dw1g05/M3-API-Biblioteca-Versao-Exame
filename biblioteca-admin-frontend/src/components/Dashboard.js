import React, { useEffect, useState } from 'react';
import { useDataProvider } from 'react-admin';

const Dashboard = () => {
  const [stats, setStats] = useState({
    totalBooks: 0,
    totalUsers: 0,
    activeLoans: 0,
    categories: 0
  });

  const dataProvider = useDataProvider();

  useEffect(() => {
    const fetchData = async () => {
      try {
        const { data: books } = await dataProvider.getList('livros', {
          pagination: { page: 1, perPage: 1000 },
          sort: { field: 'id', order: 'ASC' },
          filter: {}
        });
        
        const { data: users } = await dataProvider.getList('utilizadores', {
          pagination: { page: 1, perPage: 1000 },
          sort: { field: 'id', order: 'ASC' },
          filter: {}
        });
        
        const { data: loans } = await dataProvider.getList('emprestimos', {
          pagination: { page: 1, perPage: 1000 },
          sort: { field: 'id', order: 'ASC' },
          filter: {}
        });
        
        const { data: categories } = await dataProvider.getList('categorias', {
          pagination: { page: 1, perPage: 1000 },
          sort: { field: 'id', order: 'ASC' },
          filter: {}
        });

        setStats({
          totalBooks: books.length,
          totalUsers: users.length,
          activeLoans: loans.length,
          categories: categories.length
        });
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, [dataProvider]);

  return (
    <div style={{ padding: '20px' }}>
      <h2 style={{ marginBottom: '20px' }}>Dashboard da Biblioteca</h2>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '20px' }}>
        <div style={{ padding: '20px', border: '1px solid #ddd', borderRadius: '8px' }}>
          <h3>Total de Livros</h3>
          <p style={{ fontSize: '24px', fontWeight: 'bold' }}>{stats.totalBooks}</p>
        </div>
        <div style={{ padding: '20px', border: '1px solid #ddd', borderRadius: '8px' }}>
          <h3>Total de Usuários</h3>
          <p style={{ fontSize: '24px', fontWeight: 'bold' }}>{stats.totalUsers}</p>
        </div>
        <div style={{ padding: '20px', border: '1px solid #ddd', borderRadius: '8px' }}>
          <h3>Empréstimos Ativos</h3>
          <p style={{ fontSize: '24px', fontWeight: 'bold' }}>{stats.activeLoans}</p>
        </div>
        <div style={{ padding: '20px', border: '1px solid #ddd', borderRadius: '8px' }}>
          <h3>Categorias</h3>
          <p style={{ fontSize: '24px', fontWeight: 'bold' }}>{stats.categories}</p>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;