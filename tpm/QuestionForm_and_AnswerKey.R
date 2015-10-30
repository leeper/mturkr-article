qform <- '
<QuestionForm xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionForm.xsd">
  <Overview>
    <DisplayName>Instructions</DisplayName>
    <QuestionContent>
      <FormattedContent><![CDATA[
        <h1>Please read the following article and then answer the questions below. You must get every answer correct to pass the qualification test</h1>
		<h2>INSERT HEADLINE HERE</h2>
		<p>INSERT XHTML-FORMATTED ARTICLE TEXT HERE</p>
      ]]></FormattedContent>
    </QuestionContent>
  </Overview>
  <Question>
    <QuestionIdentifier>q1</QuestionIdentifier>
	<DisplayName>Question 1</DisplayName>
    <IsRequired>true</IsRequired>
	<QuestionContent>
      <FormattedContent><![CDATA[
        <p>TEXT OF FIRST QUESTION</p>
      ]]></FormattedContent>
	</QuestionContent>
    <AnswerSpecification>
      <SelectionAnswer>
        <StyleSuggestion>radiobutton</StyleSuggestion>
        <Selections>
          <Selection>
            <SelectionIdentifier>1</SelectionIdentifier>
            <Text>Response Option 1</Text>
          </Selection>
          <Selection>
            <SelectionIdentifier>2</SelectionIdentifier>
            <Text>Response Option 2</Text>
          </Selection>
          <Selection>
            <SelectionIdentifier>3</SelectionIdentifier>
            <Text>Response Option 3</Text>
          </Selection>
          <Selection>
            <SelectionIdentifier>4</SelectionIdentifier>
            <Text>Response Option 4</Text>
          </Selection>
        </Selections>
      </SelectionAnswer>
    </AnswerSpecification>
  </Question>
  <Question>
    <QuestionIdentifier>q2</QuestionIdentifier>
	<DisplayName>Question 2</DisplayName>
    <IsRequired>true</IsRequired>
    <QuestionContent>
      <FormattedContent><![CDATA[
        <p>TEXT OF SECOND QUESTION</p>
      ]]></FormattedContent>
	</QuestionContent>
    <AnswerSpecification>
      <SelectionAnswer>
        <StyleSuggestion>radiobutton</StyleSuggestion>
        <Selections>
          <Selection>
            <SelectionIdentifier>1</SelectionIdentifier>
            <Text>Response Option 1</Text>
          </Selection>
          <Selection>
            <SelectionIdentifier>2</SelectionIdentifier>
            <Text>Response Option 2</Text>
          </Selection>
          <Selection>
            <SelectionIdentifier>3</SelectionIdentifier>
            <Text>Response Option 3</Text>
          </Selection>
          <Selection>
            <SelectionIdentifier>4</SelectionIdentifier>
            <Text>Response Option 4</Text>
          </Selection>
        </Selections>
      </SelectionAnswer>
    </AnswerSpecification>
  </Question>
</QuestionForm>'

answers <- '
<AnswerKey xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/AnswerKey.xsd">
  <Question>
    <QuestionIdentifier>q1</QuestionIdentifier>
    <AnswerOption>
      <SelectionIdentifier>3</SelectionIdentifier>
      <AnswerScore>50</AnswerScore>
    </AnswerOption>
  </Question>
  <Question>
    <QuestionIdentifier>q2</QuestionIdentifier>
    <AnswerOption>
      <SelectionIdentifier>1</SelectionIdentifier>
      <AnswerScore>50</AnswerScore>
    </AnswerOption>
  </Question>
</AnswerKey>'