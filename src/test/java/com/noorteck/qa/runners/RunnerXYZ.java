package com.noorteck.qa.runners;

import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;

@RunWith(Karate.class)

@KarateOptions(features = "classpath:com/noorteck/qa/features/job-api/", tags = { "@jobSmokeTest" })

public class RunnerXYZ {

}