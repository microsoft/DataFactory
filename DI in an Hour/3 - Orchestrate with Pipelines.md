# Module 3: Complete Your First Data Integration Journey 

Tasks to be completed in this module:

* Add office outlook activity to send the output of copy in email 
* Add schedule in the pipeline
* Add dataflow activity into the same pipeline

## Add office outlook activity

We will use the same Pipeline created in Module 1, as its name is **First_Pipeline**.

1. Click **Activities** and scroll over until you see the **Office365 Outlook**. Then click on the Office365 Outlook activity.

![Finding the new Office365 Outlook activity in the Activities tab of the ribbon](media/module-3-new-outlook-activity.png)

2. Click **OK** to grant consent to use your e-mail address.

![Grant consent dialog for the Office365Outlook activity](media/module-3-grant-consent.png)

3. Select the e-mail account you want to use. 

    Note: we currently do not  support personal e-mail.  You must use your corporate e-mail address.

![Choose account screen for the sign in of the email account](media/module-3-choose-account.png)

4. Click Allow access to confirm.

![Confirmation required to allow access to the app](media/module-3-allow-access.png)

5. Drag “On Success” from your Copy Activity to the Office365   Outlook Activity.

![Activitied joined and now in series](media/module-3-activities-joined.png)

6. Click on the Office365 Outlook Activity configure the email.

### Configuring the Office Outlook activity

1. Click on settings
2. In the “To” section of the e-mail template, enter your e-mail address. If you want to fill in several email addresses, you can use ; to separate several email addresses (for example email1@microsoft.com; email2; email3)
3.  In the “Subject” section, click your mouse to allow the Add dynamic content option to appear, then click on the option.

![Subject line for the email](media/module-3-subject-line.png)

The Pipeline expression builder canvas will appear, and enter below command, then click **OK**.  
```@concat('DI in an Hour Pipeline Succeeded with Pipeline Run Id', pipeline ().RunId)```

![Pipeline expression builder showing the formula to be entered](media/module-3-pipeline-expression-builder.png)

4. In the **Body** section, click your mouse to allow the *add dynamic content* option to appears.  Then click on the option and enter below content, then click OK.

Note: Please replace Copy data1 with your own pipeline copy activity name.

    @concat('RunID =  ', pipeline().RunId, ' ; ',
    'Copied rows ', activity('Copy data1').output.rowsCopied, ' ; ','Throughput ', activity('Copy data1').output.throughput
    )

![Expression to be used in the Body of the email to be sent](media/module-3-new-formula-expression-builder.png)

5. Then click **Run** and then **Save and Run** to execute these activities

![Running the new activity through the Run button inside of the Home tab in the ribbon](media/module-3-run-outlook.png)

6. After running successfully, please check your email to see the sent email in your mail box.

![Output and details of the activity and the email sent](media/module-3-emails-sent.png)

![Email received in inbox](media/module-3-email.png)

## Add schedule in the Pipeline

Once you complete the development and testing of your pipeline, you can schedule the pipeline to execute automatically.

Once you complete the development and testing of your pipeline, you can schedule the pipeline to execute automatically.

1. In the Home tab of the ribbon, click the **Schedule** button.

![Schedule button inside of the Home tab of the ribbon](media/module-3-schedule.png)

2. Enter the scheduling information and click **Apply**.

The example below schedules the Pipeline to execute daily at 8:00 PM until the end of the year.

![Schedule dialog for the data pipeline set to run until the end of the year every day at 8pm](media/module-3-schedule-dialog.png)

## Add dataflow activity into the Pipeline 

You can also add the dataflow created in Module 2 into the pipeline as below.

1. Click + between you copy activity and Office Outlook activity, and select **Dataflow** in order to add your dataflow activity in between.

![Adding the dataflow activity in between the existing two activities](media/module-3-add-dataflow.png)

2. Click **Settings** tab, and select your Dataflow created in Module 2.

![Dataflow activity and settings for it where you can select the datalfow created from Module 2](media/module-3-select-dataflow.png)

Now you have created a pipeline to complete an end-to-end data integration scenario including using copy activity to ingest raw data from the source store into the bronze table of the data Lakehouse using dataflow activity to process the data and move it to the gold table of the data Lakehouse, using office outlook activity to send an email to notify you once all the jobs are complete, and finally setting up the entire flow to run on a scheduled basis.   