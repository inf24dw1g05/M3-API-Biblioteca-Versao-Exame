

import {
    List,
    Datagrid,
    TextField,
    EditButton,
    Edit,
    Create,
    SimpleForm,
    TextInput,
    required,
    useNotify,
    useRedirect,
} from 'react-admin';

export const CategoriaList = props => (
    <List {...props}>
        <Datagrid>
            <TextField source="nome" />
            <EditButton />
        </Datagrid>
    </List>
);

const CategoriaForm = props => {
    const notify = useNotify();
    const redirect = useRedirect();

    const onError = (error) => {
        if (error.body.error.message === 'Já existe uma categoria com este nome') {
            notify('Já existe uma categoria com este nome', { type: 'error' });
        }
    };

    return (
        <SimpleForm {...props} onError={onError}>
            <TextInput 
                source="nome" 
                validate={[required()]} 
                fullWidth
            />
        </SimpleForm>
    );
};

export const CategoriaEdit = props => (
    <Edit {...props}>
        <CategoriaForm />
    </Edit>
);

export const CategoriaCreate = props => (
    <Create {...props}>
        <CategoriaForm />
    </Create>
);