package com.example.batchprocessing.reader;

import com.example.batchprocessing.model.Person;

import org.springframework.batch.item.file.FlatFileItemReader;
import org.springframework.batch.item.file.mapping.DefaultLineMapper;
import org.springframework.batch.item.file.mapping.FieldSetMapper;
import org.springframework.batch.item.file.transform.DelimitedLineTokenizer;
import org.springframework.batch.item.file.transform.FieldSet;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

@Component
public class MyFlatFileItemReader extends FlatFileItemReader {
    
    public MyFlatFileItemReader(){
        this.setResource(new ClassPathResource("sample-data.csv"));

        DefaultLineMapper<Person> lineMapper = new DefaultLineMapper<>();
        lineMapper.setLineTokenizer(new DelimitedLineTokenizer());
        lineMapper.setFieldSetMapper(new PersonFieldSetMapper());

        this.setLineMapper(lineMapper);
    }
}

class PersonFieldSetMapper implements FieldSetMapper<Person> {

    public Person mapFieldSet(FieldSet fieldSet) {
        Person player = new Person();

        player.setFirstName(fieldSet.readString(0));
        player.setLastName(fieldSet.readString(1));

        return player;
    }
}
