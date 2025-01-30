
/*import {
  Count,
  CountSchema,
  Filter,
  FilterExcludingWhere,
  repository,
  Where,
} from '@loopback/repository';
import {
  del,
  get,
  getModelSchemaRef,
  param,
  patch,
  post,
  put,
  requestBody,
  response,
} from '@loopback/rest';
import {Emprestimo} from '../models';
import {EmprestimoRepository} from '../repositories';

export class EmprestimoController {
  constructor(
    @repository(EmprestimoRepository)
    public emprestimoRepository: EmprestimoRepository,
  ) {}

  @post('/emprestimos')
  @response(200, {
    description: 'Emprestimo model instance',
    content: {'application/json': {schema: getModelSchemaRef(Emprestimo)}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Emprestimo, {
            title: 'NewEmprestimo',
            exclude: ['id'],
          }),
        },
      },
    })
    emprestimo: Omit<Emprestimo, 'id'>,
  ): Promise<Emprestimo> {
    return this.emprestimoRepository.create(emprestimo);
  }

  @get('/emprestimos/count')
  @response(200, {
    description: 'Emprestimo model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(Emprestimo) where?: Where<Emprestimo>,
  ): Promise<Count> {
    return this.emprestimoRepository.count(where);
  }

  @get('/emprestimos')
  @response(200, {
    description: 'Array of Emprestimo model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Emprestimo, {includeRelations: true}),
        },
      },
    },
  })
  async find(
    @param.filter(Emprestimo) filter?: Filter<Emprestimo>,
  ): Promise<Emprestimo[]> {
    return this.emprestimoRepository.find({
      ...filter,
      include: [
        {relation: 'livro'},
        {relation: 'utilizador'}
      ],
    });
  }

  @patch('/emprestimos')
  @response(200, {
    description: 'Emprestimo PATCH success count',
    content: {'application/json': {schema: CountSchema}},
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Emprestimo, {partial: true}),
        },
      },
    })
    emprestimo: Emprestimo,
    @param.where(Emprestimo) where?: Where<Emprestimo>,
  ): Promise<Count> {
    return this.emprestimoRepository.updateAll(emprestimo, where);
  }

  @get('/emprestimos/{id}')
  @response(200, {
    description: 'Emprestimo model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(Emprestimo, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.number('id') id: number,
    @param.filter(Emprestimo, {exclude: 'where'})
    filter?: FilterExcludingWhere<Emprestimo>,
  ): Promise<Emprestimo> {
    return this.emprestimoRepository.findById(id, {
      ...filter,
      include: [
        {relation: 'livro'},
        {relation: 'utilizador'}
      ],
    });
  }

  @patch('/emprestimos/{id}')
  @response(204, {
    description: 'Emprestimo PATCH success',
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Emprestimo, {partial: true}),
        },
      },
    })
    emprestimo: Emprestimo,
  ): Promise<void> {
    await this.emprestimoRepository.updateById(id, emprestimo);
  }

  @put('/emprestimos/{id}')
  @response(204, {
    description: 'Emprestimo PUT success',
  })
  async replaceById(
    @param.path.number('id') id: number,
    @requestBody() emprestimo: Emprestimo,
  ): Promise<void> {
    await this.emprestimoRepository.replaceById(id, emprestimo);
  }

  @del('/emprestimos/{id}')
  @response(204, {
    description: 'Emprestimo DELETE success',
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.emprestimoRepository.deleteById(id);
  }
}
  */

import {
  Count,
  CountSchema,
  Filter,
  FilterExcludingWhere,
  repository,
  Where,
  WhereBuilder,
} from '@loopback/repository';
import {
  del,
  get,
  getModelSchemaRef,
  param,
  patch,
  post,
  put,
  requestBody,
  response,
  HttpErrors,
} from '@loopback/rest';
import {Emprestimo} from '../models';
import {EmprestimoRepository} from '../repositories';

export class EmprestimoController {
  constructor(
    @repository(EmprestimoRepository)
    public emprestimoRepository: EmprestimoRepository,
  ) {}

  // Nova função de validação
  async verificarDisponibilidadeLivro(
    livroId: number,
    dataEmprestimo: string,
    dataDevolucao: string,
    emprestimoId?: number,
  ): Promise<boolean> {
    const wb = new WhereBuilder<Where<Emprestimo>>();
    
    wb.and({
      livroId: livroId,
      or: [
        {
          and: [
            { dataEmprestimo: { lte: dataDevolucao } },
            { dataDevolucao: { gte: dataEmprestimo } }
          ]
        }
      ]
    });

    if (emprestimoId) {
      wb.and({ id: { neq: emprestimoId } });
    }

    const emprestimosExistentes = await this.emprestimoRepository.find({
      where: wb.build()
    });

    return emprestimosExistentes.length === 0;
  }

  @post('/emprestimos')
  @response(200, {
    description: 'Emprestimo model instance',
    content: {'application/json': {schema: getModelSchemaRef(Emprestimo)}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Emprestimo, {
            title: 'NewEmprestimo',
            exclude: ['id'],
          }),
        },
      },
    })
    emprestimo: Omit<Emprestimo, 'id'>,
  ): Promise<Emprestimo> {
    // Adiciona validação antes de criar
    const disponivel = await this.verificarDisponibilidadeLivro(
      emprestimo.livroId,
      emprestimo.dataEmprestimo,
      emprestimo.dataDevolucao
    );

    if (!disponivel) {
      throw new HttpErrors.Conflict(
        'O livro já está emprestado para este período'
      );
    }

    return this.emprestimoRepository.create(emprestimo);
  }

  @get('/emprestimos/count')
  @response(200, {
    description: 'Emprestimo model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(Emprestimo) where?: Where<Emprestimo>,
  ): Promise<Count> {
    return this.emprestimoRepository.count(where);
  }

  @get('/emprestimos')
  @response(200, {
    description: 'Array of Emprestimo model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Emprestimo, {includeRelations: true}),
        },
      },
    },
  })
  async find(
    @param.filter(Emprestimo) filter?: Filter<Emprestimo>,
  ): Promise<Emprestimo[]> {
    return this.emprestimoRepository.find({
      ...filter,
      include: [
        {relation: 'livro'},
        {relation: 'utilizador'}
      ],
    });
  }

  @patch('/emprestimos')
  @response(200, {
    description: 'Emprestimo PATCH success count',
    content: {'application/json': {schema: CountSchema}},
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Emprestimo, {partial: true}),
        },
      },
    })
    emprestimo: Emprestimo,
    @param.where(Emprestimo) where?: Where<Emprestimo>,
  ): Promise<Count> {
    return this.emprestimoRepository.updateAll(emprestimo, where);
  }

  @get('/emprestimos/{id}')
  @response(200, {
    description: 'Emprestimo model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(Emprestimo, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.number('id') id: number,
    @param.filter(Emprestimo, {exclude: 'where'})
    filter?: FilterExcludingWhere<Emprestimo>,
  ): Promise<Emprestimo> {
    return this.emprestimoRepository.findById(id, {
      ...filter,
      include: [
        {relation: 'livro'},
        {relation: 'utilizador'}
      ],
    });
  }

  @patch('/emprestimos/{id}')
  @response(204, {
    description: 'Emprestimo PATCH success',
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Emprestimo, {partial: true}),
        },
      },
    })
    emprestimo: Emprestimo,
  ): Promise<void> {
    // Adiciona validação antes de atualizar
    if (emprestimo.livroId && emprestimo.dataEmprestimo && emprestimo.dataDevolucao) {
      const disponivel = await this.verificarDisponibilidadeLivro(
        emprestimo.livroId,
        emprestimo.dataEmprestimo,
        emprestimo.dataDevolucao,
        id
      );

      if (!disponivel) {
        throw new HttpErrors.Conflict(
          'O livro já está emprestado para este período'
        );
      }
    }

    await this.emprestimoRepository.updateById(id, emprestimo);
  }

  @put('/emprestimos/{id}')
  @response(204, {
    description: 'Emprestimo PUT success',
  })
  async replaceById(
    @param.path.number('id') id: number,
    @requestBody() emprestimo: Emprestimo,
  ): Promise<void> {
    // Adiciona validação antes de substituir
    const disponivel = await this.verificarDisponibilidadeLivro(
      emprestimo.livroId,
      emprestimo.dataEmprestimo,
      emprestimo.dataDevolucao,
      id
    );

    if (!disponivel) {
      throw new HttpErrors.Conflict(
        'O livro já está emprestado para este período'
      );
    }

    await this.emprestimoRepository.replaceById(id, emprestimo);
  }

  @del('/emprestimos/{id}')
  @response(204, {
    description: 'Emprestimo DELETE success',
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.emprestimoRepository.deleteById(id);
  }
}