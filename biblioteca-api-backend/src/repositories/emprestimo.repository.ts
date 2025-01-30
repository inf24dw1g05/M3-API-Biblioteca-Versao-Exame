

import {inject, Getter} from '@loopback/core';
import {DefaultCrudRepository, repository, BelongsToAccessor} from '@loopback/repository';
import {DbDataSource} from '../datasources';
import {Emprestimo, EmprestimoRelations, Livro, Utilizador} from '../models';
import {LivroRepository} from './livro.repository';
import {UtilizadorRepository} from './utilizador.repository';

export class EmprestimoRepository extends DefaultCrudRepository<
  Emprestimo,
  typeof Emprestimo.prototype.id,
  EmprestimoRelations
> {
  public readonly livro: BelongsToAccessor<Livro, typeof Emprestimo.prototype.id>;
  public readonly utilizador: BelongsToAccessor<Utilizador, typeof Emprestimo.prototype.id>;

  constructor(
    @inject('datasources.db') dataSource: DbDataSource,
    @repository.getter('LivroRepository') protected livroRepositoryGetter: Getter<LivroRepository>,
    @repository.getter('UtilizadorRepository') protected utilizadorRepositoryGetter: Getter<UtilizadorRepository>,
  ) {
    super(Emprestimo, dataSource);
    this.livro = this.createBelongsToAccessorFor('livro', livroRepositoryGetter);
    this.utilizador = this.createBelongsToAccessorFor('utilizador', utilizadorRepositoryGetter);
    
    this.registerInclusionResolver('livro', this.livro.inclusionResolver);
    this.registerInclusionResolver('utilizador', this.utilizador.inclusionResolver);
  }
}