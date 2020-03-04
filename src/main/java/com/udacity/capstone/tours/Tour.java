package com.udacity.capstone.tours;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Tour implements Serializable{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String title;

    @Column(length = 2000)
    private String description;

    @Column(length = 2000)
    private String blurb;

    private Integer price;

    private String duration;

    @Column(length = 2000)
    private String bullets;

    private String keywords;


    @Enumerated(EnumType.STRING)
    private Difficulty difficulty;

    private String region;
}
