package it.renthub.controller.restController;

import it.renthub.model.bean.Tipologia;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RestController
@RequestMapping("/rest/annunci")
public class ControllerAnnunci {

    @GetMapping("/tipologie")
    List<String> tipologieAnnunci() {
        return Stream.of(Tipologia.values()).map(Tipologia::name).collect(Collectors.toList());
    }
}
