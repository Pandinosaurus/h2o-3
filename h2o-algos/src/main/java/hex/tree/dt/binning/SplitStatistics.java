package hex.tree.dt.binning;

import hex.tree.dt.AbstractSplittingRule;
import org.apache.commons.math3.util.Precision;

import java.util.Arrays;

/**
 * Potential split including splitting rule and statistics on count of samples and distribution of target variable.
 * Holds how many samples (and 0-samples) are in a right and left splits
 */
public class SplitStatistics {
    public AbstractSplittingRule _splittingRule;

    public int _leftCount;
    public int[] _leftClassDistribution;

    public int _rightCount;
    public int[] _rightClassDistribution;

    public SplitStatistics(int numClasses) {
        _leftCount = 0;
        _leftClassDistribution = new int[numClasses];
        _rightCount = 0;
        _rightClassDistribution = new int[numClasses];
    }

    public SplitStatistics() {
        // call constructor with default value
        this(1);
    }

    public void accumulateLeftStatistics(int leftCount, int[] leftClassDistribution) {
        _leftCount += leftCount;
        for (int i = 0; i < _leftClassDistribution.length; i++) {
            _leftClassDistribution[i] += leftClassDistribution[i];
        }
    }

    public void accumulateRightStatistics(int rightCount, int[] rightClassDistribution) {
        _rightCount += rightCount;
        for (int i = 0; i < _rightClassDistribution.length; i++) {
            _rightClassDistribution[i] += rightClassDistribution[i];
        }
    }

    public void copyLeftValues(SplitStatistics toCopy) {
        _leftCount = toCopy._leftCount;
        _leftClassDistribution = Arrays.copyOf(toCopy._leftClassDistribution, toCopy._leftClassDistribution.length);
    }

    public void copyRightValues(SplitStatistics toCopy) {
        _rightCount = toCopy._rightCount;
        _rightClassDistribution = Arrays.copyOf(toCopy._rightClassDistribution, toCopy._rightClassDistribution.length);
    }

    public SplitStatistics setCriterionValue(double criterionOfSplit) {
        _splittingRule.setCriterionValue(criterionOfSplit);
        return this;
    }

    public SplitStatistics setFeatureIndex(int featureIndex) {
        _splittingRule.setFeatureIndex(featureIndex);
        return this;
    }

    public static double entropyBinarySplitBinomial(final double oneClassFrequency) {
        return -1 * ((oneClassFrequency < Precision.EPSILON ? 0 : (oneClassFrequency * Math.log(oneClassFrequency)))
                + ((1 - oneClassFrequency) < Precision.EPSILON ? 0 : ((1 - oneClassFrequency) * Math.log(1 - oneClassFrequency))));
    }

    // todo - test it, compare to the previous one, check if additional 0-handling is needed
    public static double entropyBinarySplitMultinomial(final int[] classCountsDistribution, final int totalCount) {
        return -1 * Arrays.stream(classCountsDistribution)
                .mapToDouble(count -> (count * 1.0 / totalCount) * Math.log((count * 1.0 / totalCount))).sum();
    }

    // todo - what is the entropy for multiclass and what is important
    public Double binaryEntropy() {
        int totalCount = _leftCount + _rightCount;
        return entropyBinarySplitMultinomial(_leftClassDistribution, _leftCount) * _leftCount / totalCount
                + entropyBinarySplitMultinomial(_rightClassDistribution, _rightCount) * _rightCount / totalCount;
    }
}