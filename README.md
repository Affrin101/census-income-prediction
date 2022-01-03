# Census Income Prediction

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

-   Author: Affrin Sultana, Navya Dahiya, Philson Chan, Sukhleen Kaur

Data analysis project for Group 1 of DSCI 522 (Data Science Workflows), A course in the 2021-22 Master of Data Science program at the University of British Columbia.

## About

Often times, we want to predict a person's income based on their educational, professional and demographic background. This can be helpful for people to know what factors would help them earn more than 50K USD. Information about a person's income decides the amount of tax he pays, whether or not the person is eligible to buy a house or a car,what kind of a life he can lead. This can also be helpful for financial services firms for deciding for loan application approvals, like people who earn more than 50K USD will be granted a loan, otherwise not. Hence,it is important to look at the factors that might affect a person's income and analyze and highlight those features that could be responsible in improving an individual's income.

The data set used in this project to predict a person's income is the Census Income dataset, which is also known as the Adult dataset, and was created in 1996. It was sourced from the UCI Machine Learning Repository and the data was extracted by Barry Becker using the 1994 Census database, details of which could be found [here](https://archive-beta.ics.uci.edu/ml/datasets/census+income). The training dataset consists of 32561 examples, while the testing set has 16281 examples. The dataset that we have used consists of 14 features which is a mix of 8 categorical and 6 numerical variables containing information on age, education, nationality, marital status, relationship status, occupation, work classification, gender, race, working hours per week, capital loss and capital gain and 1 target column.

In this project we are attempting to build a classification model using the `Random Forest Classifier` algorithm which can use the `census income` data with demographic features such as level of education, age, hours dedicated to work, etc to predict whether a person's annual income will be greater than 50K USD or not.

Our classifier was able to correctly predict 83% of the test examples. Our classifier performed fairly on unseen test data with an ROC AUC score of 0.89, indicating that it is able to distinguish the positive class (income \> 50k) with 0.89 probability. Among the people whose income is actually \>50K USD, we were able to predict 70% of them correctly and among all the people who earned more than 50K USD, we were able to predict 71% of them correctly. However, it incorrectly predicted 0.064% of test examples as `false positives`. These kinds of incorrect predictions could lead people into believing that they can earn more than 50K USD by following some other career path which might not be favorable for them. It can also be misleading for financial companies as they might end up offering loans to defaulters. Thus, we recommend continuing the study to improve this prediction model before it is put into production.

The steps that were followed to accurately predict the income using the census income data have been outlined in this flowchart below.

![**Pipeline of Census Income Prediction**](https://github.com/UBC-MDS/census-income-prediction/blob/main/results/flowchart.PNG?raw=true)

## Makefile dependency diagram

The dependency diagram of the makefile can be found [here](https://ubc-mds.github.io/census-income-prediction/results/Makefile.png).

## Report

The final report can be found [here](https://ubc-mds.github.io/census-income-prediction/doc/report.html)

## Usage

There are two ways to reproduce the project:

### 1. With Docker

To reproduce the experiment and export the report, please install [Docker](!https://www.docker.com/get-started) in your machine. And then clone this GitHub repository and run the following command at the root directory of this repository:

    # Clone the repo
    git clone https://github.com/UBC-MDS/census-income-prediction.git
    cd census-income-prediction/
    
    # Pull the docker image from Docker Hub
    docker pull i234567/census-income-prediction:latest
    
 ### Non Window Users Command
    
    # Reproduce the pipeline with Docker and create the docker container from the image and run this command in the terminal of the docker container

    docker run --platform linux/amd64 --rm -it -v $(pwd):/home/census-income-prediction/ i234567/census-income-prediction:latest conda run -n census-income --no-capture-output make -C /home/census-income-prediction/ all
     # remove the flag --platform linux/amd64 for Mac non M1 users.
       
To restore the repository with no generated reports and artifacts, run the following command at the root directory of this repository.

    docker run --platform linux/amd64 --rm -it -v $(pwd):/home/census-income-prediction/ i234567/census-income-prediction:latest conda run -n census-income --no-capture-output make -C /home/census-income-prediction/ clean
    # remove the flag --platform linux/amd64 for Mac non M1 users.
    
 ### Windows Users Command
    # To Reproduce the pipeline with Docker and create the docker container from the image, run this command in the terminal of the docker container
    
    docker run --rm -it -v /$(pwd)://home//census-income-prediction i234567/census-income-prediction:latest conda run -n census-income --no-capture-output make -C //home//census-income-prediction all

To restore the repository with no generated reports and artifacts, run the following command at the root directory of this repository.

     docker run --rm -it -v /$(pwd)://home//census-income-prediction i234567/census-income-prediction:latest conda run -n census-income --no-capture-output make -C //home//census-income-prediction clean

### 2. Without Docker

To reproduce the model and report, please clone this GitHub repository, install the dependencies or create a virtual enviroment with our enviroment file.

    # Clone the repo
    git clone https://github.com/UBC-MDS/census-income-prediction.git
    cd census-income-prediction/
    conda env create -f census-income.yaml
    conda activate census-income

To run the all the script,please install [Make](!http://ftp.gnu.org/gnu/make/) in your machine.Then execute the following command in the root directory to reproduce the project.

    # Use Makefile
    make all

Alternatively, run the following commands in sequential order. All the commands should be executed at the root directory of this repository.

    # Download Training data
    python3 src/download_data.py https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data --out_dir=data/raw --file_name=train.csv

    # Download Test data:  
    python3 src/download_data.py https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test --out_dir=data/raw --file_name=test.csv

    # Data Cleaning
    python3 src/clean_data.py data/raw/train.csv data/raw/test.csv --out_dir=data/clean --train_filename=clean_train.csv --test_filename=clean_test.csv

    # EDA Script
    python3 src/eda_script.py data/clean/clean_train.csv --out_dir=results/eda

    # Model Building
    python3 src/model_building.py data/clean/clean_train.csv --out_dir=results/model/ --output_model=model.pickle

    # Model Evaluation
    python3 src/model_evaluation.py data/clean/clean_train.csv data/clean/clean_test.csv results/model/model.pickle --out_dir=results/eval

    # Rendering the Report
    Rscript -e "rmarkdown::render('doc/report.Rmd', output_format = 'github_document')"

To restore the repository with no generate reports and artifacts, run the following command at the root directory of this repository.

    make clean

*Note: If you have problem in saving plots as PNG with `altair`, try the following prompt:*

    npm install -g vega vega-cli vega-lite canvas

## Dependencies

This project requires the following softwares if you do not use Docker:

-   R Version 4.1 or above

    -   tidyverse==1.3.1

    -   knitr==1.36

-   Python 3.7 or above

    -   matplotlib>=3.2.2

    -   scikit-learn>=1.0

    -   pandas>=1.3.\*

    -   requests>=2.24.0

    -   altair>=4.1.0

    -   altair_data_server==0.4.1

    -   altair_saver==0.5.0

    -   docopt==0.6.2

    -   pandoc>=1.12.3

    -   graphviz==2.49.3
    
    -   shap>=0.40.0   

-   GNU Make Version 4.2.1

The Python dependencies for this project are mentioned in the [environment file](https://github.com/UBC-MDS/census-income-prediction/blob/main/census-income.yaml) in the directory of this project.

R Libraries `tidyverse` and `knitr` are also required. Please execute the following command:

    Rscript -e "install.packages(c('tidyverse', 'knitr'))"

If you already created a virtual environment using the steps mentioned above, you don't have to do the following, otherwise the steps to create the environment are given below:

    # Create an environment  
    conda env create --file census-income.yaml

    # Activate the environment  
    conda activate census-income

    # Deactivate the environment  

    conda deactivate

## License

The Census Income Prediction materials here are licensed under the MIT License. If re-using/re-mixing please provide attribution and link to this webpage.

## Reference

Census Income. (1996). UCI Machine Learning Repository. Click [here](https://archive-beta.ics.uci.edu/ml/datasets/census+income) to access it.

A. Liaw and M. Wiener (2002). Classification and Regression by randomForest. R News 2(3), 18--22.
