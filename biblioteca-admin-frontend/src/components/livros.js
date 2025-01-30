

import {
    List,
    Datagrid,
    TextField,
    NumberField,
    EditButton,
    Edit,
    Create,
    SimpleForm,
    TextInput,
    NumberInput,
    ReferenceInput,
    SelectInput,
    required,
    useRecordContext,
    useGetOne,
    Filter
} from 'react-admin';

const LivroFilter = (props) => (
    <Filter {...props}>
        <TextInput source="titulo" label="Título" alwaysOn />
        <TextInput source="autor" />
        <NumberInput source="anoPublicacao" label="Ano" />
        <ReferenceInput source="categoriaId" reference="categorias" label="Categoria">
            <SelectInput optionText="nome" />
        </ReferenceInput>
    </Filter>
);

const CategoriaInfo = () => {
    const record = useRecordContext();
    const { data: categoria } = useGetOne('categorias', { id: record.categoriaId });
    
    if (!categoria) return null;
    return <span>{categoria.nome}</span>;
};

export const LivroList = props => (
    <List {...props} filters={<LivroFilter />}>
        <Datagrid>
            <TextField source="titulo" label="Título" />
            <TextField source="autor" label="Autor" />
            <NumberField source="anoPublicacao" label="Ano Publicação" />
            <CategoriaInfo label="Categoria" />
            <EditButton />
        </Datagrid>
    </List>
);

const LivroForm = props => (
    <SimpleForm {...props}>
        <TextInput source="titulo" validate={[required()]} fullWidth />
        <TextInput source="autor" validate={[required()]} fullWidth />
        <NumberInput source="anoPublicacao" />
        <ReferenceInput source="categoriaId" reference="categorias">
            <SelectInput optionText="nome" />
        </ReferenceInput>
    </SimpleForm>
);

export const LivroEdit = props => (
    <Edit {...props}>
        <LivroForm />
    </Edit>
);

export const LivroCreate = props => (
    <Create {...props}>
        <LivroForm />
    </Create>
);