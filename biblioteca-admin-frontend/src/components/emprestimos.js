

import {
    List,
    Datagrid,
    TextField,
    DateField,
    ReferenceField,
    EditButton,
    Edit,
    Create,
    SimpleForm,
    DateInput,
    ReferenceInput,
    SelectInput,
    required,
    Filter,
    useRecordContext,
    useGetOne
} from 'react-admin';

const EmprestimoFilter = (props) => (
    <Filter {...props}>
        <ReferenceInput source="utilizadorId" reference="utilizadores" label="Utilizador">
            <SelectInput optionText="nome" />
        </ReferenceInput>
        <ReferenceInput source="livroId" reference="livros" label="Livro">
            <SelectInput optionText="titulo" />
        </ReferenceInput>
    </Filter>
);

const LivroInfo = () => {
    const record = useRecordContext();
    const { data: livro } = useGetOne('livros', { id: record.livroId });
    
    if (!livro) return null;
    return <span>{livro.titulo}</span>;
};

const UtilizadorInfo = () => {
    const record = useRecordContext();
    const { data: utilizador } = useGetOne('utilizadores', { id: record.utilizadorId });
    
    if (!utilizador) return null;
    return <span>{utilizador.nome}</span>;
};

export const EmprestimoList = props => (
    <List {...props} filters={<EmprestimoFilter />}>
        <Datagrid>
            <TextField source="utilizadorId" label="ID Utilizador" />
            <UtilizadorInfo label="Utilizador" />
            <TextField source="livroId" label="ID Livro" />
            <LivroInfo label="Livro" />
            <DateField source="dataEmprestimo" label="Data Empréstimo" />
            <DateField source="dataDevolucao" label="Data Devolução" />
            <EditButton />
        </Datagrid>
    </List>
);

const EmprestimoForm = props => (
    <SimpleForm {...props}>
        <ReferenceInput source="utilizadorId" reference="utilizadores">
            <SelectInput optionText="nome" validate={[required()]} />
        </ReferenceInput>
        <ReferenceInput source="livroId" reference="livros">
            <SelectInput optionText="titulo" validate={[required()]} />
        </ReferenceInput>
        <DateInput source="dataEmprestimo" validate={[required()]} />
        <DateInput source="dataDevolucao" validate={[required()]} />
    </SimpleForm>
);

export const EmprestimoEdit = props => (
    <Edit {...props}>
        <EmprestimoForm />
    </Edit>
);

export const EmprestimoCreate = props => (
    <Create {...props}>
        <EmprestimoForm />
    </Create>
);