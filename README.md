# Mobile BCI Data

Example codes for "Mobile BCI dataset of scalp- and ear-EEG with ERP and SSVEP paradigms during standing, walking, and running."
The dataset is available in figshare repository (https://doi.org/10.6084/m9.figshare.13604078)

## Description
We present a mobile dataset of electroencephalography (EEG) from scalp and ear and locomotion sensors collected from 18 subjects moving at different speeds while performing brain-computer interface (BCI) tasks. The experiments were performed under 16 different conditions (2 types of EEG devices x 4 speeds of movements x 2 types of BCI paradigms). The data were collected from 32-channel scalp-EEG, 14-channel ear-EEG, 4-channel electrooculography, and 3 inertial measurement units at the forehead, left ankle, and right ankle simultaneously. The conditions of recording were standing, slow walking, fast walking, and slight running at speeds of 0, 0.8, 1.6, and 2.0 m/sec, respectively. At each speed, two different BCI paradigms, event-related potential (ERP) and steady-state visual evoked potential (SSVEP), were recorded. To evaluate the signal quality, scalp- and ear-EEG data were qualitatively and quantitatively validated at each speed. We expect that the dataset will facilitate BCIs in diverse mobile environments to analyze brain activities and to evaluate the performance quantitatively, so as to broaden the use of practical BCIs.

## Code List
- Load_all_data: loading the dataset of all subjects, modalities, and speeds for each paradigm. (Matlab)
- Load_data_ex: loading the dataset of all subjects and speeds for each modality and paradigm. (Matlab)
- evaluation_ERP_using_LDA: Evaluating the dataset of ERP for all subjects and speeds using Linear Discriminator Analysis (LDA). (Matlab)
- evaluation_SSVEP_using_CCA: Evaluating the dataset of SSVEP for all subjects and speeds using Canonical Correlation Analysis (CCA). (Matlab)

### Developing Environment
Matlab 2019b
